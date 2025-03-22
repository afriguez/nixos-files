{ lib, config, pkgs, ... }:
let
  variant = "mocha";
  accent = "mauve";
in
{
  imports = [
    ../cli
  ];

  fonts.fontconfig.enable = true;

  home = {
    username = lib.mkDefault "fer";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "23.11";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Catppuccin-Mocha-Mauve-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
    };
    iconTheme = {
      name = "Catpuccin-papirus";
      package = (pkgs.catppuccin-papirus-folders.override {
        accent = "${accent}";
        flavor = "${variant}";
      });
    };
    theme = {
      name = "Catppuccin-GTK";
      package = (pkgs.catppuccin-gtk.override {
        accents = [ "${accent}" ];
        variant = "${variant}";
      });
    };
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;

    kitty = {
      enable = true;
      themeFile = "Catppuccin-Macchiato";
      settings = {
        shell = "fish";
        background_opacity = "0.9";
      };
      font = {
        name = "JetBrainsMono NF";
        size = 12;
      };
      shellIntegration.enableFishIntegration = true;
    };

    mpv = {
      enable = true;

      package = (
        pkgs.mpv-unwrapped.wrapper {
          scripts = with pkgs.mpvScripts; [
            mpvacious
          ];

	  mpv = pkgs.mpv-unwrapped.override {
	    waylandSupport = true;
	  };
        }
      );
    };
  };
}
