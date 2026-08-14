{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    shortcut = "a";
    shell = "${pkgs.fish}/bin/fish";
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;
    secureSocket = false;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      {
        plugin = tmuxPlugins.rose-pine;
        extraConfig = ''
          set -g @rose_pine_variant 'main'
        '';
      }
    ];

    extraConfig = ''
      set -g default-terminal 'tmux-256color'
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

      set -g allow-passthrough on
      set-environment -g COLORTERM "truecolor"
      set-option -g mouse on

      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };
}
