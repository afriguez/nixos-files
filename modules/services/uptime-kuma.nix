{
  services.uptime-kuma = {
    enable = true;
    settings = {
      HOST = "0.0.0.0";
      PORT = "3001";
      UPTIME_KUMA_DB_TYPE = "sqlite";
    };
  };
}
