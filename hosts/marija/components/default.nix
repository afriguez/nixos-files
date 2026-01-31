{ ... }: {
  imports = [
    ./services.nix
    ./hardware.nix
    ./programs.nix
    ./networking.nix
    ./system-packages.nix
  ];
}
