{
  services.uptime-kuma = {
    enable = true;
    settings = {
      PORT = "3001";
      UPTIME_KUMA_DB_HOSTNAME = "localhost";
      UPTIME_KUMA_DB_NAME = "uptime-kuma";
      UPTIME_KUMA_DB_PASSWORD = "";
      UPTIME_KUMA_DB_TYPE = "postgresql";
      UPTIME_KUMA_DB_USERNAME = "postresql";
    };
  };
}
