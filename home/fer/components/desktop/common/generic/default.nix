{ pkgs, ... }:
let
  dunst-config = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/afriguez/dotfiles/main/.config/dunst/dunstrc";
    sha256 = "sha256-v/zbWNgPc7Jh8fy10e5lTIdEDFo5n3CjUPeR1uyO0/U=";
  };
in
{
  home.packages = with pkgs; [
    krita
    firefox
    noto-fonts-cjk
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
