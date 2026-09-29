{pkgs, ...}: {
  services.navidrome = {
    enable = true;
    openFirewall = true;
    plugins = with pkgs.navidromePlugins; [
      listenbrainz-daily-playlist
      lyrics-plugin
    ];
    settings = {
      Address = "0.0.0.0";
      MusicFolder = "/srv/bulk/server/navidrome/music";
      PlaylistsPath = "/srv/bulk/server/navidrome/playlists";
    };
  };
}
