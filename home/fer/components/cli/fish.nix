{ config, pkgs, ... }:
let
  rose-pine-fish = pkgs.fetchFromGitHub {
    owner = "rose-pine";
    repo = "fish";
    rev = "0749331afd4be6bc8035a812a20e489efe1d616f";
    hash = "sha256-hOcsGt0IMoX1a02t85qeoE381XEca0F2x0AtFNwOqj0=";
  };
in
{
  home.file = {
    ".config/fish/themes/Rosé Pine Moon.theme".source = "${rose-pine-fish}/themes/Rosé Pine Moon.theme";
  };
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "ls -l --color=auto";
      n = "nnn -e -H";
      cat = "bat --theme Dracula";
      ssh = "env TERM=xterm-256color ssh";
      venv = "source .venv/bin/activate.fish";
      v = "nvim";
    };
    plugins = [
      {
        name = "fish-ssh-agent";
        src = pkgs.fetchFromGitHub {
          owner = "danhper";
          repo = "fish-ssh-agent";
          rev = "f10d95775352931796fd17f54e6bf2f910163d1b";
          sha256 = "sha256-cFroQ7PSBZ5BhXzZEKTKHnEAuEu8W9rFrGZAb8vTgIE=";
        };
      }
    ];
    interactiveShellInit = ''
      export PATH="$PATH:/home/fer/.dotnet/tools"
      set -U fish_greeting
      fish_config theme choose Rosé\ Pine\ Moon
      fish_config prompt choose astronaut

      function cd
        builtin cd $argv
        git rev-parse 2>/dev/null
        if test $status -eq 0
          if not ssh-add -l | grep -q afriguez
          ssh-add ~/external/ssh/id_ed25519
          end
          onefetch -d dependencies authors contributors license -i /home/${config.home.username}/Downloads/Wallpaper/in_use.jpg --image-protocol kitty
        end
      end

      source /home/${config.home.username}/.env
    '';
  };
}
