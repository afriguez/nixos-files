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
      ];

      exec = [
        "swww-daemon --format xrgb && swww img ~/Downloads/Wallpaper/in_use.jpg"
        "eww open bar"
      ];

      "$terminal" = "kitty";
      "$menu" = "rofi -show drun -icon-theme Papirus -show-icons";
      "$sshot" = ''grim -g "$(slurp -d)" - | wl-copy -t image/png'';
      "$music" = "youtube-music";
      "$switchkbd" = "switch_kbd_locale";
      "$session" = "kitty session";
      "$toggle_bar" = "eww open --toggle bar";
    };
  };
}
