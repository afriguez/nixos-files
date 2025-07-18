{ pkgs, ... }:
{
  imports = [
    ./binds.nix
    ./visual.nix
  ];

  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    swww
    rofi-wayland
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = ",preferred,auto,1";
     # monitor = ",highrr,auto,1";
      input = {
        kb_layout = "us";
        left_handed = true;
        follow_mouse = 1;
        touchpad.natural_scroll = "no";
        sensitivity = 0;
      };

      windowrulev2 = [
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"
      ];

      exec = [
        "swww-daemon --format xrgb && swww img ~/Downloads/Wallpaper/in_use.jpg"
        "fcitx5-remote -r"
        "fcitx5 -d --replace"
        "fcitx5-remote -r"
      ];

      "$terminal" = "kitty";
      "$menu" = "rofi -show drun -icon-theme Papirus -show-icons";
      "$sshot" = ''grim -g "$(slurp -d)" - | wl-copy -t image/png'';
      "$music" = "youtube-music";
    };
  };
}
