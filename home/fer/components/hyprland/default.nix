{ pkgs, lib, ... }: {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
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
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
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

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
        allow_tearing = false;

        "col.active_border" = "rgba(8aadf4ee) rgba(f5bde6ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = "yes";

        bezier = [ "myBezier, 0.05, 0.9, 0.1, 1.05" ];
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      misc = {
        disable_hyprland_logo = true;
      };

      windowrulev2 = [
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"
        "nomaximizerequest, class:.*"
      ];

      master = {
        new_is_master = true;
      };

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

      bind =
        let
          directions = rec {
            left = "l";
            right = "r";
            up = "u";
            down = "d";
            h = left;
            l = right;
            k = up;
            j = down;
          };
        in
        [
          "SUPER SHIFT, RETURN, exec, $terminal"
          "SUPER SHIFT, S, exec, $sshot"
          "SUPER, P, exec, $menu"
          "SUPER, W, exec, $wper"
          "SUPER CTRL, S, exec, $music"
          "SUPER SHIFT, P, exec, $session"
          "SUPER, U, exec, $switchkbd"

          "SUPER SHIFT, C, killactive,"
          "SUPER SHIFT, Q, exit,"
          "SUPER, F, togglefloating,"
          "SUPER ALT, P, pseudo,"
          "SUPER, I, togglesplit,"

          "SUPER SHIFT, H, resizeactive, -40 0"
          "SUPER SHIFT, L, resizeactive, 40 0"
          "SUPER SHIFT, K, resizeactive, 0 -40"
          "SUPER SHIFT, J, resizeactive, 0 40"
          "SUPER, M, fullscreen, 0"

          "SUPER, H, movefocus, l"
          "SUPER, L, movefocus, r"
          "SUPER, K, movefocus, u"
          "SUPER, J, movefocus, d"

          "SUPER, N, togglespecialworkspace, magic"
          "SUPER SHIFT, N, movetoworkspace, special:magic"

          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"
          "SUPER, 5, workspace, 5"
          "SUPER, 6, workspace, 6"
          "SUPER, 7, workspace, 7"
          "SUPER, 8, workspace, 8"
          "SUPER, 9, workspace, 9"
          "SUPER, 0, workspace, 10"

          "SUPER SHIFT, 1, movetoworkspace, 1"
          "SUPER SHIFT, 2, movetoworkspace, 2"
          "SUPER SHIFT, 3, movetoworkspace, 3"
          "SUPER SHIFT, 4, movetoworkspace, 4"
          "SUPER SHIFT, 5, movetoworkspace, 5"
          "SUPER SHIFT, 6, movetoworkspace, 6"
          "SUPER SHIFT, 7, movetoworkspace, 7"
          "SUPER SHIFT, 8, movetoworkspace, 8"
          "SUPER SHIFT, 9, movetoworkspace, 9"
          "SUPER SHIFT, 0, movetoworkspace, 10"
        ] ++
        (lib.mapAttrsToList
          (key: direction:
            "SUPER,${key},movefocus,${direction}"
          )
          directions) ++
        (lib.mapAttrsToList
          (key: direction:
            "SUPERSHIFT,${key},swapwindow,${direction}"
          )
          directions) ++
        (lib.mapAttrsToList
          (key: direction:
            "SUPERCONTROL,${key},movewindoworgroup,${direction}"
          )
          directions) ++
        (lib.mapAttrsToList
          (key: direction:
            "SUPERALTSHIFT,${key},movecurrentworkspacetomonitor,${direction}"
          )
          directions);

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
    };
  };
}
