# hosts/hestia.nix
{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/hestia.nix
      ../modules/common.nix  # Import common settings from the modules directory
    ];

  # Host-specific settings for Hestia
  networking.hostName = "hestia";
  services.tailscale.enable = true;

  # Packages specific to Hestia
  environment.systemPackages = with pkgs; [
    vim
    git
    tailscale
    surrealdb
    postgresql_16_jit
    rustdesk-server
  ];
}
