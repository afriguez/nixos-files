{
  description = "NixOS config flake";

  outputs =
    inputs@{ self
    , nixpkgs
    , ...
    }:
    {
      nixosConfigurations = {
        afriguez = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./nixos/configuration.nix
          ];
        };
      };
    };

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
}
