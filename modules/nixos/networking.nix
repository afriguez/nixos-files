{pkgs, ...}: {
  imports = [../shared/networking.nix];

  networking = {
    firewall.enable = false;
    networkmanager.plugins = [pkgs.networkmanager-openvpn];
  };
}
