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
      nnn = "nnn -d -e -H -r";
      cat = "bat --theme Dracula";
      ssh = "env TERM=xterm-256color ssh";
    };
    interactiveShellInit = ''
      export PATH="$PATH:/home/fer/.dotnet/tools"
      set -U fish_greeting
      fish_config theme choose Rosé\ Pine\ Moon
      fish_config prompt choose astronaut

      function cd
        builtin cd $argv
        git rev-parse 2>/dev/null
        if test $status -eq 0
          onefetch -d dependencies authors contributors license -i /home/${config.home.username}/Downloads/Wallpaper/in_use.jpg --image-protocol kitty
        end
      end

      source /home/${config.home.username}/.env
    '';
  };
}
