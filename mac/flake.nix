{
  description = "macOS Config for MacBook Pro (Athena)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-fmt.url = "github:nix-community/nixpkgs-fmt";
  };

  outputs = inputs@{ nixpkgs, darwin, home-manager, ... }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      darwinConfigurations = {
        athena = darwin.lib.darwinSystem {
          system = system;

          modules = [
            # ../hosts/athena.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              # home-manager.users.gavin = import ../hosts/athena.nix;
              home-manager.users.gavin.home.stateVersion = "24.05";

              services.nix-daemon.enable = true; # Enable the Nix daemon
              nix.useDaemon = true; # Ensure daemon mode is used
            }
          ];
        };
      };
    };
}
