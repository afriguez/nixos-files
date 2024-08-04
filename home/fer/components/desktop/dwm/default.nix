{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dmenu
    flameshot
    feh
    picom
  ];
}
