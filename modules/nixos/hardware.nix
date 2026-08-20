{pkgs, ...}: {
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    keyboard.zsa.enable = true;
    opentabletdriver.enable = true;
    xone.enable = true;

    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        libva
        libva-utils
        libvdpau-va-gl
        mesa
      ];
    };
  };
}
