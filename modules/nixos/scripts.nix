{pkgs, ...}: let
  mkScript = name:
    pkgs.writeShellScriptBin name
    (builtins.readFile ../../scripts/${name});

  scripts = map mkScript [
    "pux"
    "start-manga-ocr"
    "toggle-mic"
    "yomigrep-ocr"
  ];

  scriptDependencies = with pkgs; [
    gnugrep
    hyprshot
    libnotify
    neovim
    pipewire
    procps
    python312Packages.manga-ocr
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
