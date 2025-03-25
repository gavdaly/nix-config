{
  description = "macOS Config for MacBook Pro (Athena)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable"; # Changed to unstable
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-fmt.url = "github:nix-community/nixpkgs-fmt";
  };

  outputs = inputs@{ nixpkgs, darwin, ... }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      darwinConfigurations = {
        athena = darwin.lib.darwinSystem {
          system = system;
          
          modules = [
            ../hosts/athena.nix
            {
              # Removed home-manager configuration
              services.nix-daemon.enable = true; # Enable the Nix daemon
              nix.useDaemon = true; # Ensure daemon mode is used
            }
          ];
        };
      };
    };
}
