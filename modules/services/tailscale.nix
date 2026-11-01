{
  services.tailscale = {
    enable = true;
  };

  networking.firewall = {
    enable = true;
    interfaces."tailscale0".allowedTCPPorts = [ 443 ];
  };
}
