{
  description = "NixOS Server Infrastructure Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-fmt.url = "github:nix-community/nixpkgs-fmt";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = inputs@{ nixpkgs, nixpkgs-fmt, sops-nix, ... }:
    let
      # System types to support
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      
      # Helper to generate system configs with overlays
      genSystemConfig = system: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          sops-nix.nixosModules.sops
          ../modules/common.nix
        ];
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
        zeus = genSystemConfig "x86_64-linux" {
          imports = [ ./hosts/zeus.nix ];
        };

        # Database and services server
        hestia = genSystemConfig "x86_64-linux" {
          imports = [ ./hosts/hestia.nix ];
        };

        # Reserved for future use
        ares = genSystemConfig "x86_64-linux" {
          imports = [ ./hosts/ares.nix ];
        };

        # Kiosk display system
        hypnos = genSystemConfig "x86_64-linux" {
          imports = [ ./hosts/hypnos.nix ];
        };

        # k3s cluster nodes
        rpi-master = makeK3sNode "aarch64" "master";
        rpi-worker01 = makeK3sNode "aarch64" "worker01";
        rpi-worker02 = makeK3sNode "aarch64" "worker02";
        rpi-worker03 = makeK3sNode "aarch64" "worker03";
      };

      # Development shell with formatting tools
      devShells = builtins.listToAttrs (map
        (system: {
          name = system;
          value = nixpkgs.legacyPackages.${system}.mkShell {
            nativeBuildInputs = with nixpkgs.legacyPackages.${system}; [
              nixpkgs-fmt
              sops
            ];
          };
        })
        supportedSystems);
    };
}
