{
  imports = [
    ../shared
    ./packages.nix
    ./users.nix
    ./networking.nix
    ../services/docker.nix
    ../services/openssh.nix
    ../services/immich.nix
    ../services/jellyfin.nix
    ../services/calibre-web.nix
    ../services/qbittorrent.nix
  ];

  hardware.enableRedistributableFirmware = true;
}
