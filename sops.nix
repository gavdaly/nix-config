{
  description = "NixOS configuration with configurable hostname and system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  inputs.defaultConfig = {
    hostname = "nixos";
    system = "x86_64-linux";
  };

  outputs = { self, nixpkgs, sops-nix, ... }@inputs: {
    nixosConfigurations = {
      ${inputs.defaultConfig.hostname} = nixpkgs.lib.nixosSystem {
        system = inputs.defaultConfig.system;
        modules = [
          sops-nix.nixosModules.sops
        ];
      };
    };
  };
}
