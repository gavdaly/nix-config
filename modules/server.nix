# modules/server.nix
{ config, pkgs, ... }:

{
  # Server-specific system packages
  environment.systemPackages = with pkgs; [
    # Backup tools
    restic
    rclone

    # Network tools
    nmap
    inetutils
    iptables

    # Storage management
    parted
    gptfdisk
    smartmontools

    # System analysis
    sysstat
    atop
    glances

    # Log analysis
    goaccess
    logrotate
  ];

  # Backup service configuration
  services.restic.backups = {
    remoteBackup = {
      initialize = true;
      passwordFile = "/var/lib/restic/password";
      paths = [
        "/etc"
        "/var/lib"
        "/home"
      ];
      repository = "sftp:backup@backup-server:/backups";
      timerConfig = {
        OnCalendar = "daily";
        RandomizedDelaySec = "1h";
        Persistent = true;
      };
      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
      ];
    };
  };

  # System limits for server workloads
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "65535";
    }
    {
      domain = "*";
      type = "hard";
      item = "nofile";
      value = "65535";
    }
  ];

  # Sysctl settings for server performance
  boot.kernel.sysctl = {
    "net.core.somaxconn" = 1024;
    "net.core.netdev_max_backlog" = 5000;
    "net.ipv4.tcp_max_syn_backlog" = 8192;
    "net.ipv4.tcp_tw_reuse" = 1;
    "net.ipv4.tcp_fastopen" = 3;
    "vm.swappiness" = 10;
  };

  # Additional SSH hardening
  services.openssh = {
    extraConfig = ''
      MaxAuthTries 3
      MaxSessions 10
      TCPKeepAlive yes
      ClientAliveInterval 180
      ClientAliveCountMax 3
    '';
  };

  # Automatic security updates
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    flake = "github:gavdaly/nix-config";
    flags = [
      "--no-write-lock-file"
      "--upgrade-all"
    ];
  };

  # Enhanced logging
  services.journald.extraConfig = ''
    Storage=persistent
    Compress=yes
    SystemMaxUse=8G
    SystemMaxFileSize=256M
    MaxFileSec=1month
    ForwardToSyslog=yes
  '';
}
