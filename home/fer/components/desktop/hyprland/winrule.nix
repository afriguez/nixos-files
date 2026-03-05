{ ... }:
{
  wayland.windowManager.hyprland.settings.windowrule = [
    {
      name = "File chooser";
      "match:title" = "(?i)^(save|open) file(s)?|.* wants to (save|open)";
      float = true;
      size = "1200 700";
    }
    {
      name = "discord";
      "match:class" = "^(discord)$";
      workspace = "8 silent";
    }
    {
      name = "steam";
      "match:class" = "^(steam)$";
      workspace = "4 silent";
    }
    {
      name = "migaku";
      "match:class" = "(?i)^brave-.*-Default";
      workspace = "special:misc silent";
    }
    {
      name = "yt-music";
      "match:class" = "^(com.github.th_ch.youtube_music)$";
      workspace = "7 silent";
    }
    {
      name = "pavucontrol";
      "match:class" = "^(org.pulseaudio.pavucontrol)$";
      workspace = "2 silent";
    }
  ];
}
