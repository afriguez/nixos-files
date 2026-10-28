{ config, pkgs, ... }: {
  systemd.services.shux-routing = {
    description = "Route directly through the ISP, bypassing Proton VPN";

    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    before = [ "docker.service" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      set -eu

      IP="${pkgs.iproute2}/bin/ip"
      GREP="${pkgs.gnugrep}/bin/grep"

      if ! "$IP" -4 rule show |
           "$GREP" -Eq '^[[:space:]]*90:.*from 172\.30\.50\.10(/32)? lookup main'; then
        "$IP" -4 rule add \
          priority 90 \
          from 172.30.50.10/32 \
          lookup main
      fi

      if ! "$IP" -4 rule show |
           "$GREP" -Eq '^[[:space:]]*91:.*from 172\.30\.50\.10(/32)? prohibit'; then
        "$IP" -4 rule add \
          priority 91 \
          from 172.30.50.10/32 \
          prohibit
      fi

      echo "shux-routing rules configured"
    '';
  };
}
