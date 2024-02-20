{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./common/users/fer
  ];

  networking = {
    hostName = "marija";
    networkManager.enable = true;
  };

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
    };
  };

  time.timeZone = "America/Bogota";
  i18n.defaultLocale = "en_US.UTF-8";

  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  system.stateVersion = "23.11";
}
