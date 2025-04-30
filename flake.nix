{
  description = "NixOS Server Infrastructure Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-fmt.url = "github:nix-community/nixpkgs-fmt";
    sops-nix.url = "github:Mic92/sops-nix";
    devenv.url = "github:cachix/devenv";
  };

  outputs = inputs@{ nixpkgs, nixpkgs-fmt, sops-nix, devenv, ... }:
    let
      # System types to support
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];

      genSystemConfig = system: extraModules: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          sops-nix.nixosModules.sops
          ./modules/common.nix
        ] ++ extraModules;
      };

      # Function to generate k3s node configuration
      makeK3sNode = arch: role: nixpkgs.lib.nixosSystem {
        system = "${arch}-linux";
        specialArgs = { inherit inputs; };
        modules = [
          sops-nix.nixosModules.sops
          ./rpi-${role}.nix
          {
            networking.hostName = "k3s-${arch}-${role}";
            networking.domain = "cluster.local";
          }
        ];
      };
    in
    {
      nixosConfigurations = {
        # Development and build server
        zeus = genSystemConfig "x86_64-linux" [ ./hosts/zeus.nix ];

        # Database and services server
        hestia = genSystemConfig "x86_64-linux" [ ./hosts/hestia.nix ];

        # Reserved for future use
        #
        # Not in use yet
        # ares = genSystemConfig "x86_64-linux" [ ./hosts/ares.nix ];

        # Kiosk display system
        #
        # Not in use yet
        # hypnos = genSystemConfig "x86_64-linux" [ ./hosts/hypnos.nix ];
      };
    };
}
