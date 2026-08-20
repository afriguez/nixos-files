{lib, ...}: {
  services = {
    blueman.enable = true;
    hardware.openrgb.enable = true;

    openssh = {
      enable = true;
      ports = [22];
      settings.PasswordAuthentication = true;
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    postgresql = {
      enable = true;
      authentication = lib.mkOverride 10 ''
        #type database DBuser auth-method
        local all      all    trust
        host  all all 127.0.0.1/32 trust
        host  all all ::1/128      trust
      '';
    };
  };

  security.rtkit.enable = true;
  virtualisation.docker.enable = true;
}
