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
    nodejs
    wget
  ];

  environment.shellAliases.codex = "npx @openai/codex@latest";

  programs = {
    bash.completion.enable = true;
    git.enable = true;
  };
}
