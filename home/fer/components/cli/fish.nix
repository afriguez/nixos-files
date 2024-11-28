{ config, pkgs, ... }:
let
  catppuccin-fish = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "fish";
    rev = "0ce27b518e8ead555dec34dd8be3df5bd75cff8e";
    hash = "sha256-Dc/zdxfzAUM5NX8PxzfljRbYvO9f9syuLO8yBr+R3qg=";
  };
in
{
  home.file = {
    ".config/fish/themes/Catppuccin Macchiato.theme".source = "${catppuccin-fish}/themes/Catppuccin Macchiato.theme";
  };
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "ls -l --color=auto";
      nnn = "nnn -d -e -H -r";
      cat = "bat --theme Dracula";
      ssh = "env TERM=xterm-256color ssh";
    };
    interactiveShellInit = ''
      export PATH="$PATH:/home/fer/.dotnet/tools"
      set -U fish_greeting
      fish_config theme choose Catppuccin\ Macchiato
      fish_config prompt choose astronaut

      set kitty_count (pgrep -c -f "kitty")

      if test $kitty_count -eq 1
        neofetch --kitty ~/Downloads/pandemonica.png --size 375px
      end

      function cd
        builtin cd $argv
        git rev-parse 2>/dev/null
        if test $status -eq 0
          onefetch -d dependencies authors contributors license -i /home/${config.home.username}/Downloads/Wallpaper/n_interlude_64.png --image-protocol kitty
        end
      end
    '';
  };
}
