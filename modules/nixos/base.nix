{pkgs, ...}: {
  imports = [../shared/base.nix];

  i18n.inputMethod = {
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

  nixpkgs.config.allowUnfree = true;

  programs = {
    nano.enable = false;
    nix-ld.enable = true;
  };
}
