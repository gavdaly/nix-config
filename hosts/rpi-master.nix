{ config, pkgs, ... }:

let
  architecture =
    if pkgs.stdenv.isAarch64 then "aarch64"
    else if pkgs.stdenv.isX86_64 then "x86_64"
    else "unknown";
in
{
  networking.hostName = "k3s-${architecture}-master";

  services.openssh.enable = true;

  users.users.yourUsername = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  services.k3s.server = {
    enable = true;
    extraArgs = "--node-name=${config.networking.hostName}";
  };

  networking.firewall.allowedTCPPorts = [ 6443 80 443 ];
  networking.firewall.enable = true;

  nixpkgs.system = architecture + "-linux";
  boot.loader.grub.device = "/dev/sdX"; # Adjust according to your setup

  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";
}
