{ config, pkgs, ... }:

{
  networking.hostName = "ares";

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
