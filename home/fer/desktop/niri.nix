{pkgs, ...}: {
  home.packages = with pkgs; [
    brightnessctl
    grim
    playerctl
    rofi
    slurp
    swww
    wl-clipboard
    xwayland-satellite
  ];
}
