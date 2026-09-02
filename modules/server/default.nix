{
  imports = [
    ../shared
    ./packages.nix
    ./users.nix
    ../services/docker.nix
    ../services/openssh.nix
    ../services/immich.nix
    ../services/jellyfin.nix
    ../services/calibre-web.nix
  ];

  hardware.enableRedistributableFirmware = true;
}
