{
  pkgs,
  inputs,
  outputs,
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../common/users/fer
    ../common/generic
    ./components

    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  boot.loader.grub.minegrub-theme.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.kernelModules = [ "v4l2loopback" ];
  virtualisation.docker.enable = true;

  nixpkgs.overlays = [
    (import ./components/firebase-tools.nix)
  ];

  system.stateVersion = "23.11";
}
