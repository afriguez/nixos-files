{ pkgs, inputs, outputs, ... }:
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
  virtualisation.docker.enable = true;

  system.stateVersion = "23.11";
}
