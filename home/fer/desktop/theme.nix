{
  inputs,
  pkgs,
  ...
}: let
  variant = "mocha";
  accent = "mauve";
  marija-cursors = inputs.marija-cursors.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  fonts.fontconfig.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    package = marija-cursors;
    name = "furina";
    size = 16;
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        inherit accent;
        flavor = variant;
      };
    };

    theme = {
      name = "catppuccin-mocha-mauve-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [accent];
        inherit variant;
      };
    };

    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  };
}
