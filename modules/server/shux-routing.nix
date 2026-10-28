{ config, pkgs, ... }: {
  systemd.services.shux-routing = {
    description = "Bypass Proton VPN for shux traffic";

    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      set -eu

      IPTABLES="${pkgs.iptables}/bin/iptables"

      # Proton's fwmark is 0xca6c.
      if ! "$IPTABLES" -t mangle -C PREROUTING \
          -s 172.30.50.10/32 \
          -m comment --comment shux-bypass-proton \
          -j MARK --set-xmark 0xca6c/0xffffffff 2>/dev/null; then
        "$IPTABLES" -t mangle -I PREROUTING 1 \
          -s 172.30.50.10/32 \
          -m comment --comment shux-bypass-proton \
          -j MARK --set-xmark 0xca6c/0xffffffff
      fi

      echo "shux Proton bypass packet marking configured"
    '';
  };
}
