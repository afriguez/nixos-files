{ pkgs, ... }: {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    discord
    noto-fonts-cjk
    swww
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
