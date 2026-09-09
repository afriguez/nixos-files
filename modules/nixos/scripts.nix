{pkgs, ...}: let
  mkScript = name:
    pkgs.writeShellScriptBin name
    (builtins.readFile ../../scripts/${name});

  yomigrep = pkgs.callPackage ../../pkgs/yomigrep.nix { };

  scripts = (map mkScript [
    "pux"
    "start-manga-ocr"
    "toggle-mic"
    "yomigrep-ocr"
  ]) ++ [ yomigrep ];

  scriptDependencies = with pkgs; [
    gnugrep
    hyprshot
    libnotify
    neovim
    pipewire
    procps
    python3Packages.manga-ocr
    tmux
    wireplumber
    wl-clipboard
    xclip
    xsel
    zoxide
  ];
in {
  environment = {
    homeBinInPath = true;
    systemPackages = scripts ++ scriptDependencies;
  };
}
