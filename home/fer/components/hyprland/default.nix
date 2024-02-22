{ pkgs, ... }: {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    discord
    noto-fonts-cjk
    swww
    eww-wayland
    dunst
    libnotify
    rofi-wayland
    transmission_4-gtk
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  wayland.windowManager.hyprland.enable = true;
}
