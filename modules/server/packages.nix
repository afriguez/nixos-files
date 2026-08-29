{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    curl
    nh
    htop
    jq
    just
    neovim
    ripgrep
    tmux
    tree
    unzip
    wget
  ];

  programs = {
    bash.completion.enable = true;
    git.enable = true;
  };
}
