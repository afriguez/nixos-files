{
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 0;
      gaps_out = 0;
      border_size = 1;
      layout = "dwindle";
      allow_tearing = false;

      "col.active_border" = "rgba(8aadf4ee) rgba(f5bde6ee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";
    };

    decoration = {
      rounding = 0;
      blur.enabled = false;
      shadow.enabled = false;
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
  };
}
