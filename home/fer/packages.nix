{
  inputs,
  pkgs,
  ...
}: {
  home.packages =
    (with pkgs; [
      # CLI
      bat
      fastfetch
      feh
      fzf
      htop
      jq
      nb
      onefetch
      p7zip
      ripgrep
      socat
      w3m
      wget
      zoxide
      (nnn.override {withNerdIcons = true;})

      # Desktop applications
      anki-bin
      awatcher
      brave
      discord
      dunst
      keymapp
      krita
      libnotify
      mplayer
      pear-desktop
      prismlauncher
      proton-vpn
      reco
      rnote
      transmission_4-gtk

      # Development and media tools
      cmake
      beamPackages.elixir
      ffmpeg-full
      gcc
      gamescope
      hyprshot
      inotify-tools
      libva-utils
      luarocks-nix
      neovim
      nodejs
      pavucontrol
      pulseaudio
      shellcheck
      unzip
      uv
      vim

      # System maintenance
      just
      nh

      # Fonts
      nerd-fonts.jetbrains-mono
      noto-fonts-cjk-sans
    ])
    ++ [
      inputs.gamesentenceminer.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.herdr.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
}
