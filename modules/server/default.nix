{
  imports = [
    ../shared
    ./packages.nix
    ./users.nix
    ../services/docker.nix
    ../services/openssh.nix
    ../services/thermald.nix
    ../services/uptime-kuma.nix
  ];

  hardware.enableRedistributableFirmware = true;
}
