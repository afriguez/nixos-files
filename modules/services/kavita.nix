{
  services.kavita = {
    enable = true;
    tokenKeyFile = "/etc/kavita-token";
  };

  networking.firewall.allowedTCPPorts = [ 5000 ];
}
