{pkgs, ...}: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;

    package = pkgs.steam.override {
      extraLibraries = pkgs: [pkgs.libxcb];
      extraPkgs = pkgs:
        with pkgs; [
          gamemode
          keyutils
          libkrb5
          libpng
          libpulseaudio
          libvorbis
          libxcursor
          libxi
          libxinerama
          libxscrnsaver
          stdenv.cc.cc.lib
        ];
    };

    extraCompatPackages = [pkgs.proton-ge-bin];
  };
}
