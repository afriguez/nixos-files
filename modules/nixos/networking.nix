{pkgs, ...}: {
  networking = {
    hostName = "marija";
    firewall.enable = false;

    networkmanager = {
      enable = true;
      plugins = [pkgs.networkmanager-openvpn];
    };
  };
}
