{pkgs, ...}: {
  i18n = {
    defaultLocale = "en_US.UTF-8";

    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-gtk
          fcitx5-mozc
        ];
      };
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;
  programs = {
    nano.enable = false;
    nix-ld.enable = true;
  };

  time.timeZone = "America/Bogota";
}
