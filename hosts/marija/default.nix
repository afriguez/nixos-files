{ pkgs, inputs, outputs, ... }:
let
  image = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/afriguez/dotfiles/624d9ab011fcfbcd41a0af4451cc160531b87abe/Downloads/Wallpaper/n_interlude_64.png";
    sha256 = "11xdxxlayk1byxvwp7l1280c715y5c7gzsd0i8d6kchykdsymkzf";
  };
in
{
  imports = [
    ./hardware-configuration.nix
    ./common/users/fer

    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.extraSpecialArgs = { inherit inputs outputs; };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking = {
    hostName = "marija";
    networkmanager.enable = true;
  };

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      minegrub-theme = {
        enable = true;
      };
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
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
    xserver = {
      enable = true;
      displayManager = {
        sddm = {
          enable = true;
          theme = "chili";
        };
      };
    };
  };

  programs = {
    steam.enable = true;
    nano.enable = false;
    hyprland.enable = true;
  };

  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;

    extraPackages = [ pkgs.amdvlk ];
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };

  environment.systemPackages = with pkgs; [
    discord
    (sddm-chili-theme.override {
      themeConfig = {
        background = image;
      };
    })
  ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11";
}
