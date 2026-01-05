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
    networkmanager = {
      enable = true;
      plugins = with pkgs; [ networkmanager-openvpn ];
    };
  };

  boot.loader.grub.minegrub-theme.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services = {
    gnome.gnome-keyring.enable = true;
    blueman.enable = true;
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
      };
    };
    xserver = {
      enable = true;
    };
    displayManager = {
      sddm = {
        package = pkgs.kdePackages.sddm;
        enable = true;
        theme = "where_is_my_sddm_theme";
        extraPackages = [
          pkgs.qt6.qt5compat
        ];
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
    nix-ld.enable = true;
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
  };

  hardware = {
    keyboard.zsa.enable = true;
    opentabletdriver.enable = true;
    graphics = {
      enable = true;
    };
    bluetooth.enable = true;
    xone.enable = true;
  };

  virtualisation.docker.enable = true;

  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override { };
  };

  environment = {
    systemPackages = with pkgs; [
      inputs.boosteroid.packages.${pkgs.stdenv.hostPlatform.system}.boosteroid
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      # python3
      keymapp
      discord
      cmake
      elixir
      unzip
      erlang
      ffmpeg-full
      gamescope
      pavucontrol
      godot_4
      adb-sync
      android-tools
      scrcpy
      ripgrep
      bruno
      prismlauncher
      vim
      brave
      uv
      luarocks-nix
      inotify-tools
      conda
      qview
      gcc
      python312Packages.manga-ocr
      tidal-hifi
      onlyoffice-desktopeditors
      kdePackages.qtdeclarative
      (where-is-my-sddm-theme.override {
        themeConfig.General = {
          background = image;
        };
      })
    ];
  };

  system.stateVersion = "23.11";
}
