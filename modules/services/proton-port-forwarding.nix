{ config, pkgs, ... }:

let
  protonPortForward = pkgs.writeShellScript "proton-port-forward" ''
    set -uo pipefail

    GATEWAY="10.2.0.1"
    QB_URL="http://127.0.0.1:8080"

    COOKIE_JAR="$(${pkgs.coreutils}/bin/mktemp)"
    trap '${pkgs.coreutils}/bin/rm -f "$COOKIE_JAR"' EXIT

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

      login_qbittorrent || {
        echo "qBittorrent login failed"
        return 1
      }

      ${pkgs.curl}/bin/curl \
        --silent \
        --show-error \
        --fail \
        --cookie "$COOKIE_JAR" \
        --data-urlencode \
        "json={\"listen_port\":$PORT,\"upnp\":false,\"random_port\":false}" \
        "$QB_URL/api/v2/app/setPreferences" >/dev/null
    }

    echo "Waiting for Proton NAT-PMP gateway..."

    until ${pkgs.libnatpmp}/bin/natpmpc \
      -g "$GATEWAY" >/dev/null 2>&1
    do
      ${pkgs.coreutils}/bin/sleep 5
    done

    echo "Proton NAT-PMP gateway reachable"

    CURRENT_PORT=""

    while true; do
      echo "Refreshing Proton port mapping..."

      UDP_OUTPUT="$(
        ${pkgs.libnatpmp}/bin/natpmpc \
          -a 1 0 udp 60 \
          -g "$GATEWAY" 2>&1
      )"

      UDP_STATUS=$?

      if [ "$UDP_STATUS" -ne 0 ]; then
        echo "UDP NAT-PMP request failed:"
        echo "$UDP_OUTPUT"
        ${pkgs.coreutils}/bin/sleep 5
        continue
      fi

      PORT="$(
        printf '%s\n' "$UDP_OUTPUT" |
          ${pkgs.gnused}/bin/sed -n \
            's/.*Mapped public port \([0-9][0-9]*\).*/\1/p'
      )"

      if [ -z "$PORT" ]; then
        echo "Could not parse forwarded port:"
        echo "$UDP_OUTPUT"
        ${pkgs.coreutils}/bin/sleep 5
        continue
      fi

      TCP_OUTPUT="$(
        ${pkgs.libnatpmp}/bin/natpmpc \
          -a 1 0 tcp 60 \
          -g "$GATEWAY" 2>&1
      )"

      TCP_STATUS=$?

      if [ "$TCP_STATUS" -ne 0 ]; then
        echo "TCP NAT-PMP request failed:"
        echo "$TCP_OUTPUT"
        ${pkgs.coreutils}/bin/sleep 5
        continue
      fi

      echo "NAT-PMP lease refreshed: port $PORT"

      if [ "$PORT" != "$CURRENT_PORT" ]; then
        if set_qbittorrent_port "$PORT"; then
          CURRENT_PORT="$PORT"
          echo "qBittorrent updated to port $PORT"
        else
          echo "Failed to update qBittorrent; will retry next cycle"
        fi
      fi

      ${pkgs.coreutils}/bin/sleep 45
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
