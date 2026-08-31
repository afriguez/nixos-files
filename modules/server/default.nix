{
  imports = [
    ../shared
    ./packages.nix
    ./users.nix
    ../services/docker.nix
    ../services/openssh.nix
    ../services/uptime-kuma.nix
    ../services/immich.nix
    ../services/jellyfin.nix
    ../services/calibre-web.nix
    ../services/vaultwarden.nix
  ];

  hardware.enableRedistributableFirmware = true;
}
