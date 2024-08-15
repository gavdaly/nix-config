# hosts/zeus.nix
{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/zeus.nix
      ../modules/common.nix
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

  # Sound setup
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

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
    vim
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
    xwayland
    meson
    wayland-protocols
    wayland-utils
    wl-clipboard
    wlroots
    nixpkgs-fmt
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
