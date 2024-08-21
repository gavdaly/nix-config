{ config, pkgs, ... }:
{
  # Common networking settings
  networking.networkmanager.enable = true;

  services.tailscale.enable = true;

  # SSH and Firewall
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # GnuPG settings
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.syncthing.enable = true;

  environment.systemPackages = with pkgs; [
    tailscale
    syncthing
  ];
}
