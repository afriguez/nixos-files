{ pkgs, ... }:
let
  image = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/afriguez/dotfiles/624d9ab011fcfbcd41a0af4451cc160531b87abe/Downloads/Wallpaper/n_interlude_64.png";
    sha256 = "11xdxxlayk1byxvwp7l1280c715y5c7gzsd0i8d6kchykdsymkzf";
  };
in
{
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
      nodejs
      protonvpn-gui
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
}
