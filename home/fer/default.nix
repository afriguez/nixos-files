{
  config,
  lib,
  ...
}: {
  imports = [
    ./dotfiles.nix
    ./packages.nix
    ./programs
    ./desktop
  ];

  home = {
    username = lib.mkDefault "fer";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "23.11";

    sessionPath = [
      "${config.home.homeDirectory}/.dotnet/tools"
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  programs.home-manager.enable = true;
}
