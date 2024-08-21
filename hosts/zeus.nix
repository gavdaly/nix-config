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
      ../modules/sound.nix
      ../modules/terminal.nix
      ../modules/virtualisation.nix
      ../modules/wasm.nix
    ];

  # Host-specific settings for Zeus
  networking.hostName = "zeus";

  # Wayland/Hyprland configuration
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "hyprland";
  services.displayManager.sddm.wayland.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Wayland environment variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  services.syncthing.enable = true;
  services.tailscale.enable = true;
  # Packages specific to Zeus
  users.users.gavin.packages = with pkgs; [
    cosmic-files
    cosmic-launcher
    onagre
    wayvnc
    mpv
    zed-editor
    warp-terminal
    obsidian
    tailscale
    syncthing
    jetbrains.rust-rover
    vscode
  ];

  environment.systemPackages = with pkgs; [
    eww
    hyprland
    waybar
    libnotify
    wezterm
    alacritty
    rofi-wayland
    starship
    chromium
    swww
    xdg-desktop-portal-hyprland
    # xwayland
    meson
    wayland-protocols
    wayland-utils
    wl-clipboard
    wlroots
    kitty
    telegram-desktop
  ];

  fonts.packages = with pkgs; [
    font-awesome
    powerline-fonts
    powerline-symbols
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
}
