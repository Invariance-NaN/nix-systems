{
  description = "My Nix systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [ ];

      flake = {
        nixosConfigurations.secondary = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [ ./modules/base.nix ./modules/secondary.nix ];
        };
      };

      perSystem = { config, pkgs, ... }: {
        packages.image = self.nixosConfigurations.secondary.config.system.build.digitalOceanImage;
      };
    };
}
