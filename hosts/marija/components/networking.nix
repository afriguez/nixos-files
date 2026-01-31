{ pkgs, ... }: {
  networking = {
    firewall.enable = false;
    hostName = "marija";
    networkmanager = {
      enable = true;
      plugins = with pkgs; [ networkmanager-openvpn ];
    };
  };
}
