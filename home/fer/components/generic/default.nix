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
      nerd-fonts.jetbrains-mono
    ];
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
  };
}
