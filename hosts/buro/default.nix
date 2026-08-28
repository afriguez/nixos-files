{
  imports = [
    ./hardware-configuration.nix
    ../../modules/server
  ];

  networking.hostName = "buro";
  system.stateVersion = "26.05";
}
