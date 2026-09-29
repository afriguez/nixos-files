{
  users.users.fer = {
    isNormalUser = true;
    description = "Fer L.";
    extraGroups = [
      "docker"
      "networkmanager"
      "wheel"
      "media"
    ];
  };

  users.groups.media = {};
  users.users.calibre-web.extraGroups = [ "media" ];
  users.users.jellyfin.extraGroups = [ "media" "video" "render" ];
  users.users.qbittorrent.extraGroups = [ "media" ];
  users.users.paperless.extraGroups = [ "media"];
  #users.users.navidrome.extraGroups = [ "media" ];
}
