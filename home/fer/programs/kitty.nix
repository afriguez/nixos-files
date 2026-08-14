{
  programs.kitty = {
    enable = true;
    themeFile = "rose-pine";
    extraConfig = "background #101119";

    keybindings = {
      "kitty_mod+y" = "new_tab_with_cwd";
      "kitty_mod+l" = "select_tab";
    };

    settings = {
      shell = "fish";
      background_opacity = "0.8";
      tab_bar_style = "hidden";
    };

    font = {
      name = "JetBrainsMono NF";
      size = 16;
    };

    shellIntegration.enableFishIntegration = true;
  };
}
