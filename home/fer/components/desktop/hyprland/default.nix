{ pkgs, inputs, ... }:
let
  quickshell = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
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
    rofi
    eww
    quickshell
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

      workspace = [
        "special:magic, border:false, on-created-empty:$terminal"
        "special:misc, on-created-empty:anki"
      ];

      windowrulev2 = [
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"
        "float, class:^(input_window)$"
      ];

      exec = [
        "swww-daemon --format xrgb && swww img ~/Downloads/Wallpaper/in_use.jpg"
        "fcitx5-remote -r"
        "fcitx5 -d --replace"
        "fcitx5-remote -r"
      ];

      exec-once = [
        "gnome-keyring-daemon --start --components=secrets,pkcs11"
      ];

      "$terminal" = "kitty";
      "$menu" = "rofi -show drun -icon-theme Papirus -show-icons";
      "$sshot" = ''grim -g "$(slurp -d)" - | wl-copy -t image/png'';
      "$music" = "youtube-music";
      "$fcitx5_toggle" = "pkill fcitx5 || fcitx5 -d --replace";
      "$show_time" = "notify-send \"$(date '+%B %d %Y')\" \"$(date '+%A, %H:%M:%S')\" -a \"Date & Time\"";
      "$sshot_temp" = ''
        mkdir -p ~/Pictures/temp_screenshots && \
        grim -g "$(slurp -d)" ~/Pictures/temp_screenshots/screenshot_$(date +%s).png && \
        find ~/Pictures/temp_screenshots -type f -mtime +1 -delete
      '';
    };
  };
}
