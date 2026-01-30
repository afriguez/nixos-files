{ pkgs, ... }: {
  imports = [
    ./git.nix
    ./fish.nix
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    zoxide
    neovim
    p7zip
    htop
    bat
    socat
    jq
    neofetch
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
