{
  services = {
    redis.servers.immich.logLevel = "warning";
    immich = {
      enable = true;
      host = "0.0.0.0";
      openFirewall = true;
    };
  };

  systemd.services.immich-server.unitConfig = {
    ConditionPathIsMountPoint = "/home/fer/external";
  };
}
