{pkgs, ...}: {
  services.navidrome = {
    enable = true;
    address = "0.0.0.0";
    openFirewall = true;
    plugins = with pkgs.navidromePlugins; [
      listenbrainz-daily-playlist
      lyrics-plugin
    ];
    settings = {
      MusicFolder = "/srv/bulk/server/navidrome/music"
      PlaylistsPath = "/srv/bulk/server/navidrome/playlists"
    };
  };
}
