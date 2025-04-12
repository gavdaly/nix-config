{config, lib, pkgs, ...}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/neon.nix
  ];

  # Enable Neon database service
  services.neon = {
    enable = true;
    dataDir = "/var/lib/neon";
    port = 55432;  # Default Neon port
    settings = {
      max_connections = 100;
      shared_buffers = "2GB";
      effective_cache_size = "6GB";
      maintenance_work_mem = "512MB";
      checkpoint_completion_target = 0.9;
      wal_buffers = "16MB";
      default_statistics_target = 100;
      random_page_cost = 1.1;  # Optimized for SSDs
      effective_io_concurrency = 200;
      work_mem = "20MB";
      min_wal_size = "1GB";
      max_wal_size = "4GB";
    };
  };

  # System users
  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "neon" ];
    initialPassword = "changeme";
  };

  # Ensure data directory exists with correct permissions
  systemd.tmpfiles.rules = [
    "d /var/lib/neon 0750 neon neon -"
  ];

  # Open firewall ports for Neon
  networking.firewall.allowedTCPPorts = [ 55432 ];  # Neon compute node
  networking.firewall.allowedTCPPorts = [ 9898 ];   # Neon HTTP API
  networking.firewall.allowedTCPPorts = [ 5454 ];   # Neon safekeeper

  # System configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "zeus";
  networking.networkmanager.enable = true;

  # Basic system packages
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    htop
    postgresql    # For psql client
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "23.11";
}