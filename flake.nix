{
  description = "Pruned Nixos Config for FW16 Standalone";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self
    , nixpkgs
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      systems = [
        #"aarch64-linux"
        #"i686-linux"
        "x86_64-linux"
        #"aarch64-darwin"
        #"x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      nixosConfigurations = {
        FW16 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/FW16/default.nix
          ];
        };
      };

      devShells = forAllSystems (system:
        let pkgs = (import nixpkgs {inherit system; });
        in {
          default = pkgs.mkShell {
            buildInputs = [
              pkgs.nil
              pkgs.nixos-anywhere
            ];
          };
        }
      );
    };
}
