{
  services = {
    redis.servers.immich.logLevel = "warning";
    immich = {
      enable = true;
      host = "0.0.0.0";
      openFirewall = true;
      mediaLocation = "/home/fer/external/server/immich";
    };
  };

  systemd.services.immich-server.unitConfig = {
    ConditionPathIsMountPoint = "/home/fer/external";
  };
}
