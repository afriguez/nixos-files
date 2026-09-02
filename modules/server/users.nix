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
  users.users.jellyfin.extraGroups = [ "media" ];
  users.users.qbittorrent.extraGroups = [ "media" ];
}
