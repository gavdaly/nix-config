{
  description = "MacOS Base Nix";
  inputs = {
    nixpkgs = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = "github:nix-community/home-manager/master";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =  {
    darwinConfiguration.main = inputs.darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      
    };
  };
}