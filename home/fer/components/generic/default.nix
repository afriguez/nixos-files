{ lib, config, ... }: {
  home = {
    username = lib.mkDefault "fer";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "23.11";
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
