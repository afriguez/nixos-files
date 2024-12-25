{
  description = "NixOS config flake";

  outputs =
    inputs@{ self
    , nixpkgs
    , home-manager
    , minegrub-theme
    , ...
    }:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
    in
    {
      inherit lib;
      nixosConfigurations = {
        marija = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/marija minegrub-theme.nixosModules.default ];
        };
        omaru = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/omaru ];
        };
      };

      homeConfigurations = {
        "fer@marija" = lib.homeManagerConfiguration {
          modules = [ ./home/fer/marija.nix ];
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "fer@omaru" = lib.homeManagerConfiguration {
          modules = [ ./home/fer/omaru.nix ];
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };
}
