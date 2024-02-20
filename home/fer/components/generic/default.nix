{ lib, config, ... }: {
  home = {
    username = lib.mkDefault "fer";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "23.11";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
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
  };
}
