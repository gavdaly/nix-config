{
  description = "First Base Config with Kubernetes k3s Cluster Support and MacBook Pro (Athena)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
  let
    pkgs = import nixpkgs { system = "aarch64-darwin"; };
  in
  {
    nixosConfigurations = {
      zeus = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/zeus.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.gavin = import ./home.nix;
          }
        ];
      };

      hestia = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/hestia.nix ];
      };

      # Configuration for MacBook Pro (Athena)
      athena = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.gavin = import ./hosts/athena.nix;
          }
        ];
      };

      rpi-master = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [ ./rpi-master.nix ];
      };

      rpi-worker01 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [ ./rpi-worker01.nix ];
      };

      rpi-worker02 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [ ./rpi-worker02.nix ];
      };

      rpi-worker03 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [ ./rpi-worker03.nix ];
      };
    };

    # Provide a default package that is an actual derivation
    defaultPackage = {
      aarch64-darwin = pkgs.mkShell {
        buildInputs = [
          pkgs.git
          pkgs.zsh
          pkgs.neovim
        ];
      };
    };
  };
}