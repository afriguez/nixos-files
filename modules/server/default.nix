{
  imports = [
    ../shared
    ./packages.nix
    ./users.nix
    ../services/docker.nix
    ../services/openssh.nix
    ../services/uptime-kuma.nix
  ];

  hardware.enableRedistributableFirmware = true;
}
