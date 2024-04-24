{ pkgs, ... }:
let
  dunst-config = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/afriguez/dotfiles/main/.config/dunst/dunstrc";
    sha256 = "sha256-v/zbWNgPc7Jh8fy10e5lTIdEDFo5n3CjUPeR1uyO0/U=";
  };
in
{
  imports = [
    ./binds.nix
    ./visual.nix
  ];

  home.packages = with pkgs; [
    krita
    firefox
    grim
    slurp
    wl-clipboard
    noto-fonts-cjk
    swww
    eww-wayland
    dunst
    libnotify
    rofi-wayland
    transmission_4-gtk
    youtube-music
    anki
    rnote
  ];

  home.file = {
    ".config/dunst/dunstrc".source = dunst-config;
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = ",highrr,auto,1";
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad.natural_scroll = "no";
        sensitivity = 0;
      };

      windowrulev2 = [
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"
        "nomaximizerequest, class:.*"
      ];

      exec = [
        "swww init && sleep 1 && swww img ~/Downloads/Wallpaper/n_interlude_64.png"
        "eww open bar"
      ];

      "$terminal" = "kitty";
      "$menu" = "rofi -show drun -icon-theme Papirus -show-icons";
      "$sshot" = ''grim -g "$(slurp -d)" - | wl-copy -t image/png'';
      "$wper" = "swww img ~/Downloads/Wallpaper/n_interlude_64.png";
      "$music" = "youtube-music";
      "$switchkbd" = "switch_kbd_locale";
      "$session" = "kitty session";
      "$toggle_bar" = "eww open --toggle bar";
    };
  };
}
