{ pkgs, ... }: {
  hardware = {
    keyboard.zsa.enable = true;
    opentabletdriver.enable = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        mesa
        libvdpau-va-gl
        libva
        libva-utils
      ];
    };
    bluetooth.enable = true;
    xone.enable = true;
  };
}
