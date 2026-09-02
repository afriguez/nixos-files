{
  services.calibre-web = {
    enable = true;
    openFirewall = true;
    listen = {
      ip = "0.0.0.0";
      port = 8083;
    };
  };

  systemd.services.calibre-web.serviceConfig.SupplementaryGroups = [ "media" ];
}
