{
  description = "My Nix systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    auth-server.url = "github:Invariance-NaN/auth";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
  let
    systemFrom = modules: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      inherit modules;
    };
  in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      flake = {
        nixosConfigurations.base = systemFrom [ ./modules/base.nix ];
        nixosConfigurations.secondary = systemFrom [ ./modules/base.nix ./modules/secondary.nix ];
      };

      perSystem = { config, pkgs, ... }: {
        packages.image = self.nixosConfigurations.base.config.system.build.digitalOceanImage;
      };
    };
}
