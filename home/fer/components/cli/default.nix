{ pkgs, ... }: {
  imports = [
    ./git.nix
    ./fish.nix
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    zoxide
    fastfetch
    p7zip
    htop
    bat
    socat
    jq
    brightnessctl
    fzf
    onefetch
    wget
    nb
    feh
    ripgrep
    w3m
    (nnn.override { withNerdIcons = true; })
  ];
}
