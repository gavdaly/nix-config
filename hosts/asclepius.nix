{ config, pkgs, ... }:

{
  networking.hostName = "asclepius";

  imports =
    [
      ../modules/common.nix
      ../modules/terminal.nix
      ../modules/network.nix
      ../modules/nix.nix
    ];

  environment.systemPackages = with pkgs; [
  ];
}
