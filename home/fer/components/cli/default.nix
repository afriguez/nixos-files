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
    cmatrix
    brightnessctl
    fzf
    onefetch
    wget
    (nnn.override { withNerdIcons = true; })
  ];
}
