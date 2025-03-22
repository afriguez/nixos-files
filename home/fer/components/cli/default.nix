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
    (nnn.override { withNerdIcons = true; })
  ];
}
