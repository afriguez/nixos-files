{pkgs, ...}: {
  imports = [../shared/boot.nix];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader.grub = {
      useOSProber = true;
      minegrub-theme.enable = true;
    };
  };
}
