{ config, pkgs, ... }:

let
  # Detect the system architecture dynamically
  architecture =
    if pkgs.stdenv.isAarch64 then "aarch64"
    else if pkgs.stdenv.isX86_64 then "x86_64"
    else "unknown";
in
{
  # Define the hostname including the architecture
  networking.hostName = "k3s-${architecture}-worker";

  services.openssh.enable = true;

  users.users.yourUsername = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  # k3s agent configuration
  services.k3s.agent = {
    enable = true;
    extraArgs = "--node-name=${config.networking.hostName}";
    server = "https://k3s-aarch64-master:6443"; # Adjust if master is on a different architecture
    tokenFile = "/var/lib/rancher/k3s/server/node-token"; # Ensure this token is distributed from the master
  };

  networking.firewall.allowedTCPPorts = [ 10250 80 443 ];
  networking.firewall.enable = true;

  nixpkgs.system = architecture + "-linux";
  boot.loader.grub.device = "/dev/sdX"; # Adjust to your setup

  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";
}
