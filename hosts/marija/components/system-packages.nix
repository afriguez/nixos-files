{ pkgs, inputs, ... }:
let
  image = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/afriguez/dotfiles/624d9ab011fcfbcd41a0af4451cc160531b87abe/Downloads/Wallpaper/n_interlude_64.png";
    sha256 = "11xdxxlayk1byxvwp7l1280c715y5c7gzsd0i8d6kchykdsymkzf";
  };
in
{
  environment = {
    homeBinInPath = true; 
    systemPackages = with pkgs; [
      inputs.gamesentenceminer.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.herdr.packages.${pkgs.stdenv.hostPlatform.system}.default
      keymapp
      neovim
      discord
      cmake
      elixir
      unzip
      ffmpeg-full
      libva-utils
      gamescope
      pavucontrol
      pulseaudio
      ripgrep
      prismlauncher
      vim
      brave
      uv
      luarocks-nix
      inotify-tools
      gcc
      python312Packages.manga-ocr
      nodejs
      protonvpn-gui
      busybox
      bubblewrap
      kdePackages.qtdeclarative
      reco
      (where-is-my-sddm-theme.override {
        themeConfig.General = {
          background = image;
        };
      })
    ];
  };
}
