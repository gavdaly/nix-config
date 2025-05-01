# hosts/zeus.nix
{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/zeus.nix
      ../modules/bluetooth.nix
      ../modules/common.nix
      ../modules/network.nix
      ../modules/nix.nix
      ../modules/rust.nix
      ../modules/terminal.nix
      ../modules/virtualisation.nix
      ../modules/wasm.nix
    ];

  # Host-specific settings for Zeus
  networking.hostName = "zeus";
  system.stateVersion = "25.05";

  users.users.gavin.shell = pkgs.zsh;
}
