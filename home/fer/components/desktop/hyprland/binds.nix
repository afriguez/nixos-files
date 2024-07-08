{ lib, ... }: {
  wayland.windowManager.hyprland.settings = {
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
        "SUPER CTRL, S, exec, $music"
        "SUPER SHIFT, P, exec, $session"
        "SUPER, U, exec, $switchkbd"
        "SUPER, B, exec, $toggle_bar"

        "SUPER SHIFT, C, killactive,"
        "SUPER SHIFT, Q, exit,"
        "SUPER, F, togglefloating,"
        "SUPER ALT, P, pseudo,"
        "SUPER, I, togglesplit,"

        "SUPER CTRL SHIFT, H, resizeactive, -40 0"
        "SUPER CTRL SHIFT, L, resizeactive, 40 0"
        "SUPER CTRL SHIFT, K, resizeactive, 0 -40"
        "SUPER CTRL SHIFT, J, resizeactive, 0 40"
        "SUPER, M, fullscreen, 0"

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
          "SUPER SHIFT,${key},swapwindow,${direction}"
        )
        directions) ++
      (lib.mapAttrsToList
        (key: direction:
          "SUPER CTRL,${key},movewindoworgroup,${direction}"
        )
        directions) ++
      (lib.mapAttrsToList
        (key: direction:
          "SUPER ALT SHIFT,${key},movecurrentworkspacetomonitor,${direction}"
        )
        directions);

    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
  };
}
