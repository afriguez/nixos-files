{
  imports = [
    ./fish.nix
    ./git.nix
    ./kitty.nix
    ./tmux.nix
  ];

  programs = {
    mpv.enable = true;
    starship.enable = true;
  };
}
