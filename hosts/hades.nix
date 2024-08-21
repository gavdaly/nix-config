{ config, pkgs, ... }:

{
  networking.hostName = "hades";

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
