{ lib, config, pkgs, ... }: {
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
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  programs = {
    zellij = {
      enable = true;
      settings = {
        theme = "catppuccin-macchiato";
      };
    };
    home-manager.enable = true;
    git.enable = true;

    kitty = {
      enable = true;
      theme = "Catppuccin-Macchiato";
      settings = {
        shell = "fish";
        single_window_padding_width = 10;
        background_opacity = "1";
      };
      font = {
        name = "JetBrainsMono NFM";
        size = 12;
      };
      shellIntegration.enableFishIntegration = true;
    };
  };
}
