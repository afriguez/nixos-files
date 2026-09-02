{ config, pkgs, ... }:
let
  protonPortForward = pkgs.writeShellScript "proton-port-forward" ''
    set -euo pipefail

    GATEWAY="10.2.0.1"
    QB_URL="http://127.0.0.1:8080"

    COOKIE_JAR="$(mktemp)"
    trap 'rm -f "$COOKIE_JAR"' EXIT

    login_qbittorrent() {
      ${pkgs.curl}/bin/curl \
        --silent \
        --show-error \
        --fail \
        --cookie-jar "$COOKIE_JAR" \
        --data-urlencode "username=$QB_USERNAME" \
        --data-urlencode "password=$QB_PASSWORD" \
        "$QB_URL/api/v2/auth/login" >/dev/null
    }

    set_qbittorrent_port() {
      PORT="$1"

      echo "Setting qBittorrent listening port to $PORT"

      ${pkgs.curl}/bin/curl \
        --silent \
        --show-error \
        --fail \
        --cookie "$COOKIE_JAR" \
        --data-urlencode \
        "json={\"listen_port\":$PORT,\"upnp\":false,\"random_port\":false}" \
        "$QB_URL/api/v2/app/setPreferences" >/dev/null
    }

    until ${pkgs.libnatpmp}/bin/natpmpc -g "$GATEWAY" >/dev/null 2>&1; do
      echo "Waiting for Proton NAT-PMP gateway..."
      sleep 5
    done

    login_qbittorrent

    CURRENT_PORT=""

    while true; do
      UDP_OUTPUT="$(
        ${pkgs.libnatpmp}/bin/natpmpc \
          -a 1 0 udp 60 \
          -g "$GATEWAY"
      )"

      PORT="$(
        printf '%s\n' "$UDP_OUTPUT" |
          ${pkgs.gnused}/bin/sed -n \
            's/.*Mapped public port \([0-9][0-9]*\).*/\1/p'
      )"

      if [ -z "$PORT" ]; then
        echo "Could not determine Proton forwarded port."
        echo "$UDP_OUTPUT"
        exit 1
      fi

      ${pkgs.libnatpmp}/bin/natpmpc \
        -a 1 0 tcp 60 \
        -g "$GATEWAY" >/dev/null

      if [ "$PORT" != "$CURRENT_PORT" ]; then
        login_qbittorrent
        set_qbittorrent_port "$PORT"

        CURRENT_PORT="$PORT"
        echo "Proton forwarded port is now $PORT"
      fi

      sleep 45
    done
  '';
in
{
  systemd.services.proton-port-forward = {
    description = "Proton VPN NAT-PMP port forwarding for qBittorrent";

    after = [
      "wg-quick-proton.service"
      "qbittorrent.service"
    ];

    requires = [
      "wg-quick-proton.service"
      "qbittorrent.service"
    ];

    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";

      EnvironmentFile = "/etc/qbittorrent-proton.env";

      ExecStart = protonPortForward;

      Restart = "always";
      RestartSec = 5;
    };
  };
}
