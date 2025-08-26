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
      awatcher
      nerd-fonts.jetbrains-mono
      (catppuccin-papirus-folders.override {
        accent = "${accent}";
        flavor = "${variant}";
      })
      (catppuccin-gtk.override {
        accents = [ "${accent}" ];
        variant = "${variant}";
      })
      catppuccin-cursors.mochaDark
    ];
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
    home-manager.enable = true;
    git.enable = true;

    kitty = {
      enable = true;
      themeFile = "gruvbox-dark";
      #extraConfig = "background #101119";
      #extraConfig = "background #32302f";
      keybindings = {
        "kitty_mod+y" = "new_tab_with_cwd";
      };
      settings = {
        shell = "fish";
        background_opacity = "0.9";
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
