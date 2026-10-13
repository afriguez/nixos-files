{
  power.ups = {
    enable = true;
    mode = "standalone";

    ups.apc = {
      driver = "usbhid-ups";
      port = "auto";
      description = "APC Back-UPS BX2000M";

      directives = [
        "vendorid = 051d"
        "productid = 0002"
      ];
    };

    users.nut-primary = {
      passwordFile = "/etc/nut-primary-password";
      upsmon = "primary";
    };

    upsmon = {
      monitor.apc = {
        system = "apc@localhost";
        powerValue = 1;
        user = "nut-primary";
        passwordFile = "/etc/nut-primary-password";
        type = "primary";
      };

      settings = {
        FINALDELAY = 0;
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8081 ];
}
