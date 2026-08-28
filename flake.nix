{
  description = "NixOS config flake";

  outputs = inputs @ {
    self,
    nixpkgs,
    minegrub-theme,
    ...
  }: let
    inherit (self) outputs;
    lib = nixpkgs.lib;
  in {
    inherit lib;
    nixosConfigurations = {
      marija = lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./hosts/marija minegrub-theme.nixosModules.default];
      };

      buro = lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./hosts/buro];
      };
    };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
    marija-cursors.url = "github:afriguez/marija-cursors";
    gamesentenceminer.url = "gitlab:afriguez/gsm-flake";
    herdr.url = "github:herdrdev/herdr";
  };
}
