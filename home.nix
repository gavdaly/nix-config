{ config, pkgs, ... }:

{
  home.username = "gavin";
  home.homeDirectory = "/home/gavin";

  home.packages = [
    pkgs.htop
    pkgs.fortune
  ];

  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Gavin";
    userEmail = "gavin@gavdev.xyz";
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    icons = true;
  };

  programs.starship = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
