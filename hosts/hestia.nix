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
    signal.relayHosts = [ "100.96.182.34" ];
  };

  services.couchdb = {
    enable = true;
    package = pkgs.couchdb;
    bindAddress = "0.0.0.0";
    package = pkgs.couchdb3;
    adminUser = "admin";
    adminPass = "password";
  };

  # Packages specific to Hestia
  environment.systemPackages = with pkgs; [
    postgresql_16_jit
    rustdesk-server
  ];
}
