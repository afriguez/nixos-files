{pkgs, ...}: let
  rose-pine-fish = pkgs.fetchFromGitHub {
    owner = "rose-pine";
    repo = "fish";
    rev = "0749331afd4be6bc8035a812a20e489efe1d616f";
    hash = "sha256-hOcsGt0IMoX1a02t85qeoE381XEca0F2x0AtFNwOqj0=";
  };
in {
  xdg.configFile."fish/themes/Rosé Pine Moon.theme".source = "${rose-pine-fish}/themes/Rosé Pine Moon.theme";

  programs.fish = {
    enable = true;

    shellAliases = {
      codex = "npx @openai/codex@latest";
      ls = "ls -l --color=auto";
      cat = "bat --theme Dracula";
      ssh = "env TERM=xterm-256color ssh";
      venv = "source .venv/bin/activate.fish";
      t = "pux";
      v = "nvim";
    };

    plugins = [
      {
        name = "fish-ssh-agent";
        src = pkgs.fetchFromGitHub {
          owner = "danhper";
          repo = "fish-ssh-agent";
          rev = "f10d95775352931796fd17f54e6bf2f910163d1b";
          hash = "sha256-cFroQ7PSBZ5BhXzZEKTKHnEAuEu8W9rFrGZAb8vTgIE=";
        };
      }
    ];

    interactiveShellInit = ''
      set -g fish_greeting
      fish_config theme choose Rosé\ Pine\ Moon
      fish_config prompt choose astronaut
      fish_hybrid_key_bindings

      function handle_change --on-variable PWD
        git rev-parse 2>/dev/null
        if test $status -eq 0
          if not ssh-add -l | grep -q afriguez
            ssh-add "$HOME/.ssh/id_ed25519"
          end
          onefetch -d dependencies authors contributors license -i "$HOME/Downloads/Wallpaper/in_use.jpg" --image-protocol kitty
        end
      end

      zoxide init --cmd cd fish | source

      if test -f "$HOME/.env"
        source "$HOME/.env"
      end

      if test -z "$TMUX"
        fastfetch
      end
    '';
  };
}
