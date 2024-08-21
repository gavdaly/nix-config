# hosts/hestia.nix
{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/hestia.nix
      ../modules/common.nix
      ../modules/terminal.nix
      ../modules/network.nix
      ../modules/nix.nix
    ];

  # Host-specific settings for Hestia
  networking.hostName = "hestia";

  services.rustdesk-server = {
    enable = true;
    openFirewall = true;
    relayIP = "100.96.182.34";
  };

  # Packages specific to Hestia
  environment.systemPackages = with pkgs; [
    postgresql_16_jit
    rustdesk-server
  ];
}
