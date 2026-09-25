{
  imports = [
    ./fish.nix
    ./git.nix
    ./kitty.nix
    ./tmux.nix
    ./obs.nix
  ];

  programs = {
    mpv.enable = true;
    starship.enable = true;
  };
}
