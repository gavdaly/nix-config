# modules/rust.nix
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rustup
    cargo
  ];
}