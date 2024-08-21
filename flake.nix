{
  description = "First Base Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    # unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:

    {
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
          system = "x86_64-linux"; # Add the system architecture for Hestia
          modules = [
            ./hosts/hestia.nix
          ];
        };

      };
    };
}
