{pkgs, ...}: let
  sddm-background = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/afriguez/dotfiles/624d9ab011fcfbcd41a0af4451cc160531b87abe/Downloads/Wallpaper/n_interlude_64.png";
    sha256 = "11xdxxlayk1byxvwp7l1280c715y5c7gzsd0i8d6kchykdsymkzf";
  };
in {
  environment.systemPackages = with pkgs; [
    bubblewrap
    busybox
    kdePackages.qtdeclarative
    (where-is-my-sddm-theme.override {
      themeConfig.General.background = sddm-background;
    })
  ];

  programs = {
    niri.enable = true;
    noisetorch.enable = true;
  };

  services = {
    gnome.gnome-keyring.enable = true;
    xserver.enable = true;

    displayManager.sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "where_is_my_sddm_theme";
      extraPackages = [pkgs.qt6.qt5compat];
    };
  };
}
