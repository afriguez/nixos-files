{ pkgs, config, ... }: {
  users.users.fer = {
    isNormalUser = true;
    description = "Fer L.";
    extraGroups = [ "networkmanager" "wheel" "docker" "adbusers" ];
    packages = [
      pkgs.home-manager
    ];
  };

  home-manager.users.fer = import ../../../../home/fer/${config.networking.hostName}.nix;
}
