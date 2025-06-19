{
  # To update a remote host, use:
  #     nixos-rebuild switch --flake .#<system> --build-host <host> --target-host <host> --use-remote-sudo --use-substitutes

  description = "My Nix systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    vscode-server.url = "github:nix-community/nixos-vscode-server";
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
