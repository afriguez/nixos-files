{ config, pkgs, inputs, outputs, ... }:
let
  image = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/afriguez/dotfiles/624d9ab011fcfbcd41a0af4451cc160531b87abe/Downloads/Wallpaper/n_interlude_64.png";
    sha256 = "11xdxxlayk1byxvwp7l1280c715y5c7gzsd0i8d6kchykdsymkzf";
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

  # boot.extraModulePackages = with config.boot.kernelPackages; [
  #   v4l2loopback
  # ];
  boot.loader.grub.minegrub-theme.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services = {
    openssh = {
      enable = true;
      ports = [22];
      settings = {
        PasswordAuthentication = true;
      };
    };
    xserver = {
      enable = true;
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
      package = pkgs.steam.override {
        extraLibraries = pkgs: [ pkgs.xorg.libxcb ];
        extraPkgs = pkgs: with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
          gamemode
        ];
      };
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
    hyprland.enable = true;
    noisetorch.enable = true;
    # adb.enable = true;
  };

  hardware = {
    opentabletdriver.enable = true;
    graphics = {
      enable = true;
      extraPackages = [ pkgs.amdvlk ];
      extraPackages32 = [ pkgs.driversi686Linux.amdvlk ]; 
    };
    xone.enable = true;
  };

  virtualisation.docker.enable = true;

  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
    };
  };

  environment = {
    systemPackages = with pkgs; [
      inputs.boosteroid.packages.${pkgs.system}.boosteroid
      inputs.zen-browser.packages.${pkgs.system}.default
      # python3
      discord
      cmake
      # nodejs
      # elixir
      # go
      # cargo
      unzip
      # gleam
      erlang
      ffmpeg-full
      # brave
      # obsidian
      gamescope
      # openvpn
      # networkmanager-openvpn
      # networkmanagerapplet
      # chromium
      pavucontrol
      # godot_4
      # v4l-utils
      # droidcam
      adb-sync
      # appimage-run
      android-tools
      scrcpy
      ripgrep
      bruno
      # pnpm
      # prismlauncher
      # nodePackages.eas-cli
      # nodePackages.firebase-tools
      vim
      inotify-tools
      conda
      # python312Packages.manga-ocr
      (sddm-chili-theme.override {
        themeConfig = {
          background = image;
        };
      })
    ];
  };

  system.stateVersion = "23.11";
}
