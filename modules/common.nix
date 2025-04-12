# modules/common.nix
{ config, pkgs, ... }:

{
  # Basic system configuration
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";
  
  # System packages
  environment.systemPackages = with pkgs; [
    # System monitoring
    htop
    iotop
    nload
    ncdu
    
    # System utilities
    tmux
    git
    vim
    wget
    curl
    ripgrep
    fd
    
    # Security tools
    ufw
    fail2ban
    
    # Diagnostics
    mtr
    tcpdump
    lsof
    
    # Process management
    killall
    tree
    psmisc
  ];

  # Enhanced system security
  security = {
    sudo.wheelNeedsPassword = true;
    auditd.enable = true;
  };

  # Basic firewall configuration
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ]; # SSH
    allowPing = true;
  };

  # SSH server hardening
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      KbdInteractiveAuthentication = false;
      X11Forwarding = false;
    };
  };

  # System monitoring and logging
  services = {
    # System monitoring
    prometheus = {
      enable = true;
      exporters = {
        node = {
          enable = true;
          enabledCollectors = [ "systemd" ];
        };
      };
    };

    # Log management
    journald.extraConfig = ''
      SystemMaxUse=2G
      MaxRetentionSec=1month
    '';
  };

  # Automatic system maintenance
  nix = {
    # Automatic garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    
    # Optimize store
    settings.auto-optimise-store = true;
    optimise.automatic = true;
  };

  # User configuration
  users.users.gavin = {
    isNormalUser = true;
    description = "gavin";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFFEUgt52irn+QG6ibCaWnW632cSmCYa8hYGCZZEcTG2 gavin@gavdaly.com"
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBCosaz3SJJU/l4RBJ/bXohaWToOih8xSvcfPbaqZkeg+N3pSfzSXgBQyyUPuxb01ZIskYlHH39XEki8or+3zTp8= ipad Key"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDlDDM/gBM9zVJYK4KB0LOX6WY/h5SbY57QgqFg6T7RQi9/sqo54tNhtcgJPJV69fV16y8VT7Sjfy3WPCWyV7zMRteIJGX/PVRqcrBZmhvmxhzwa+DYgSx9PG2RklOXREksm3/FoBhbXEUDnrLCwgvYy5M10TXBYDZobD25+pxdaBu57YUsRfdcieUkAq0UkjAI5DCe0kCi45xvryrl44PjRZ47lXOOu3aeB/iWN4/Xhb1+dhCFKIo7ZRF54LlAF1Ds8fjRLyfELpanOqTPGKAbFJlY9Z41A0oY4brvd6sVHRfTTKmKsxZAlJKsoRzNeC8RatWF4DJ4SYx2WPF+0WCcVsfDyVZeC7Oe/jpMHcng4hygfSxD2bkQMnfvjg8ymDoo3I1Wj5j56DOtEdIfJYyxcwx4+CQZMtcy5csF0E8RDYXPoR5+AqVJWJhcpuBo/Dfbl+RZwPpvc01yX8d7z3PF8F35U9AFkhh79lochXEv4MzEUhHcI4ym6tWxXVi5nFJV4bWtRRqYU4Mttx5bg3NQeIYMqKJMjSmH8CJBNG0H+nVwgazl/wac3RcT47ADE9TsYzFmkDUQQek65mZBEUi8NABwhqpZEFZqXRuWactb89X9CvMr6hFiUP8zU1yZ5GOEQpep/avmsuCLS3LQVqR1lvUuNUsxXNQvFLfKd0V9Ow== gavin@gav.local"
    ];
  };

  # Fail2ban configuration
  services.fail2ban = {
    enable = true;
    jails = {
      ssh-iptables = ''
        enabled = true
        filter = sshd
        maxretry = 5
        findtime = 600
        bantime = 600
      '';
    };
  };

  # Set system state version
  system.stateVersion = "24.05";
}
