{
  description = "First Base Config with Kubernetes k3s Cluster Support and MacBook Pro (Athena)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: let
    # Define a mapping of architectures to NixOS system identifiers
    architectures = {
      aarch64 = "aarch64-linux";
      x86_64 = "x86_64-linux";
      armv7l = "armv7l-linux";  # Example for 32-bit ARM
      # Add more architectures as needed
    };

    # Function to generate system configuration for a given architecture and role
    makeSystem = arch: role: nixpkgs.lib.nixosSystem {
      system = architectures.${arch};
      modules = [
        {
          imports = [ ./rpi-${role}.nix ];

          # Set the hostname using the architecture and role
          networking.hostName = "k3s-${arch}-${role}";

          # Other system-specific or role-specific configurations
        }
      ];
    };
  in {
    nixosConfigurations = {
      # Existing systems
      zeus = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./hosts/zeus.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.gavin = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };

      hestia = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";  # Add the system architecture for Hestia
        modules = [
          ./hosts/hestia.nix
        ];
      };

      # MacBook Pro (Athena) configuration
      athena = nixpkgs.lib.nixosSystem {
        system = "aarch64-darwin";  # MacBook Pro with M2 uses aarch64 architecture on macOS

        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.gavin = import ./hosts/athena.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to athena-home.nix
          }
        ];
      };

      # k3s nodes for Raspberry Pi at the bottom
      rpi-master = makeSystem "aarch64" "master";
      rpi-worker01 = makeSystem "aarch64" "worker01";
      rpi-worker02 = makeSystem "aarch64" "worker02";
      rpi-worker03 = makeSystem "aarch64" "worker03";

      # Add additional architectures and roles as needed
      # rpi-armv7l-master = makeSystem "armv7l" "master";
      # rpi-armv7l-worker01 = makeSystem "armv7l" "worker01";
    };
  };
}
