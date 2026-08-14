{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  users.users.fer = {
    isNormalUser = true;
    description = "Fer L.";
    extraGroups = [
      "adbusers"
      "docker"
      "networkmanager"
      "wheel"
    ];
    packages = [pkgs.home-manager];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    useGlobalPkgs = true;
    useUserPackages = true;
    users.fer = import ../../home/fer;
  };
}
