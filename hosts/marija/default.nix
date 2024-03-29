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
    ./common/generic

    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  networking = {
    firewall.enable = false;
    hostName = "marija";
    networkmanager.enable = true;
  };

  boot.loader.grub.minegrub-theme.enable = true;

  services = {
    xserver = {
      enable = true;
      displayManager = {
        sddm = {
          enable = true;
          theme = "chili";
        };
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
    steam.enable = true;
    hyprland.enable = true;
    noisetorch.enable = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;

    extraPackages = [ pkgs.amdvlk ];
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };

  virtualisation.docker.enable = true;

  environment = {
    sessionVariables = {
      DOTNET_ROOT = "${pkgs.dotnet-sdk_8}";
    };
    systemPackages = with pkgs; [
      prismlauncher
      discord
      cmake
      nodejs
      elixir
      go
      cargo
      unzip
      gleam
      erlang
      dotnet-sdk_8
      (sddm-chili-theme.override {
        themeConfig = {
          background = image;
        };
      })
    ];
  };

  system.stateVersion = "23.11";
}
