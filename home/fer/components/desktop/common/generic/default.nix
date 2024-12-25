{ pkgs, ... }:
let
  dunst-config = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/afriguez/dotfiles/main/.config/dunst/dunstrc";
    sha256 = "sha256-S0/PM9uN8hwXccL+VKqQBtVpf9hq9uKv2nkZRPIaGO4=";
  };
in
{
  home.packages = with pkgs; [
    krita
    firefox
    noto-fonts-cjk-sans
    eww
    dunst
    libnotify
    transmission_4-gtk
    youtube-music
    anki
    rnote
  ];

  home.file = {
    ".config/dunst/dunstrc".source = dunst-config;
  };
}
