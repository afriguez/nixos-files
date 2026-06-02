{ pkgs, ... }:
{
  programs = {
    niri.enable = true;
    nix-ld.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      package = pkgs.steam.override {
        extraLibraries = pkgs: [ pkgs.libxcb ];
        extraPkgs =
          pkgs: with pkgs; [
            libxcursor
            libxi
            libxinerama
            libxscrnsaver
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib
            libkrb5
            keyutils
            gamemode
          ];
      };
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
    #hyprland.enable = true;
    noisetorch.enable = true;
  };
}
