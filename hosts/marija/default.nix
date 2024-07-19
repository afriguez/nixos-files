{ config, pkgs, inputs, outputs, ... }:
let
  image = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/afriguez/dotfiles/624d9ab011fcfbcd41a0af4451cc160531b87abe/Downloads/Wallpaper/n_interlude_64.png";
    sha256 = "11xdxxlayk1byxvwp7l1280c715y5c7gzsd0i8d6kchykdsymkzf";
  };
  dwm = pkgs.fetchFromGitHub {
    owner = "afriguez";
    repo = "dwm";
    rev = "ebeab23bc8567c89680c8921dba0afbb19166e52";
    sha256 = "sha256-bFh2tSFEptPTQTJBwm/8eCjj1Y7JqpWukeofQEwdwcI=";
  };
in
{
  imports = [
    ./hardware-configuration.nix
    ../common/users/fer
    ../common/generic

    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  networking = {
    firewall.enable = false;
    hostName = "marija";
    networkmanager.enable = true;
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.loader.grub.minegrub-theme.enable = true;

  services = {    
    xserver = {
      enable = true;
      windowManager.dwm = {
        enable = true;
        package = pkgs.dwm.overrideAttrs {
          src = dwm;
        };
      };
    };
    displayManager = {
      sddm = {
        enable = true;
        theme = "chili";
      };
    };
    postgresql = {
      enable = true;
      authentication = pkgs.lib.mkOverride 10 ''
        #type database DBuser auth-method
        local all      all    trust
        host  all all 127.0.0.1/32 trust
        host  all all ::1/128      trust
      '';
    };
  };

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    hyprland.enable = true;
    noisetorch.enable = true;
  };

  hardware = {
    opentabletdriver.enable = true;
    graphics = {
      enable = true;
      extraPackages = [ pkgs.amdvlk ];
      extraPackages32 = [ pkgs.driversi686Linux.amdvlk ]; 
    };
  };

  virtualisation.docker.enable = true;

  environment = {
    systemPackages = with pkgs; [
      discord
      cmake
      nodejs
      elixir
      go
      cargo
      unzip
      gleam
      erlang
      ffmpeg-full
      brave
      obsidian
      gamescope
      openvpn
      networkmanager-openvpn
      networkmanagerapplet
      chromium
      pavucontrol
      godot_4
      v4l-utils
      droidcam
      adb-sync
      android-tools
      (sddm-chili-theme.override {
        themeConfig = {
          background = image;
        };
      })
    ];
  };

  system.stateVersion = "23.11";
}
