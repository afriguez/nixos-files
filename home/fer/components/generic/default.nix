{ lib, config, pkgs, inputs, ... }:
let
  variant = "mocha";
  accent = "mauve";
  marija-cursors = inputs.marija-cursors.packages.${pkgs.stdenv.hostPlatform.system}.default;
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
    pointerCursor = {
      gtk.enable = true;
      package = marija-cursors;
      name = "furina";
      size = 16;
    };
    packages = with pkgs; [
      awatcher
      nerd-fonts.jetbrains-mono
    ];
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = (pkgs.catppuccin-papirus-folders.override {
        accent = "${accent}";
        flavor = "${variant}";
      });
    };
    theme = {
      name = "catppuccin-mocha-mauve-standard";
      package = (pkgs.catppuccin-gtk.override {
        accents = [ "${accent}" ];
        variant = "${variant}";
      });
    };
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };

  services = {
    activitywatch = {
      enable = true;
      watchers = {
        awatcher = {
          package = pkgs.awatcher;
          executable = "awatcher";
        };
      };
    };
  };

  programs = {
    starship.enable = true;
    home-manager.enable = true;
    git.enable = true;

    kitty = {
      enable = true;
      themeFile = "rose-pine";
      extraConfig = "background #101119";
      #extraConfig = "background #32302f";
      keybindings = {
        "kitty_mod+y" = "new_tab_with_cwd";
        "kitty_mod+l" = "select_tab";
      };
      settings = {
        shell = "fish";
        background_opacity = "0.85";
        tab_bar_style = "hidden";
      };
      font = {
        name = "JetBrainsMono NF";
        size = 16;
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
