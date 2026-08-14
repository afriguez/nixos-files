{pkgs, ...}: {
  home.packages = with pkgs; [
    brightnessctl
    grim
    playerctl
    rofi
    slurp
    awww
    wl-clipboard
    xwayland-satellite
  ];
}
