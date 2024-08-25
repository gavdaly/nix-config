{
  # Specify your Nixpkgs and overlays
  imports = [
    (import <nixpkgs> {
      overlays = [
        (import (builtins.fetchTarball {
          url = "https://github.com/Mic92/sops-nix/archive/master.tar.gz";
        }))
      ];
    })
  ];

  # Configuration options
  config,
  pkgs,
  ... }: let

  # Define the user, can be set in configuration.nix
  user = config.user.name or "default";

  in {

  # Sops secrets configuration
  sops.secrets = {
    ssh_key = {
      keyFile = ./ssh_key.enc;
      age = ./age.key;
    };
  };

  # User configuration
  users.users."${user}" = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      (sops.secrets.ssh_key.outPath)
    ];
  };
}
