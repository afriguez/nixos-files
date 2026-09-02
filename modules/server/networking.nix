{
  networking.wg-quick.interfaces = {
    configFile = "/etc/wireguard/proton.conf";
    autostart = true;
  };
}
