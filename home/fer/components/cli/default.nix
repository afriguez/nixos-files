{ pkgs, ... }: {
  imports = [
    ./git.nix
    ./fish.nix
  ];

  home.packages = with pkgs; [
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
