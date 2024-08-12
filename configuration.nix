{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "zeus";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "hyprland";
  services.displayManager.sddm.wayland.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Hint Electon apps to use wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.tailscale.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gavin = {
    isNormalUser = true;
    description = "gavin";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
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
    ];
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBCosaz3SJJU/l4RBJ/bXohaWToOih8xSvcfPbaqZkeg+N3pSfzSXgBQyyUPuxb01ZIskYlHH39XEki8or+3zTp8= ipad Key"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDlDDM/gBM9zVJYK4KB0LOX6WY/h5SbY57QgqFg6T7RQi9/sqo54tNhtcgJPJV69fV16y8VT7Sjfy3WPCWyV7zMRteIJGX/PVRqcrBZmhvmxhzwa+DYgSx9PG2RklOXREksm3/FoBhbXEUDnrLCwgvYy5M10TXBYDZobD25+pxdaBu57YUsRfdcieUkAq0UkjAI5DCe0kCi45xvryrl44PjRZ47lXOOu3aeB/iWN4/Xhb1+dhCFKIo7ZRF54LlAF1Ds8fjRLyfELpanOqTPGKAbFJlY9Z41A0oY4brvd6sVHRfTTKmKsxZAlJKsoRzNeC8RatWF4DJ4SYx2WPF+0WCcVsfDyVZeC7Oe/jpMHcng4hygfSxD2bkQMnfvjg8ymDoo3I1Wj5j56DOtEdIfJYyxcwx4+CQZMtcy5csF0E8RDYXPoR5+AqVJWJhcpuBo/Dfbl+RZwPpvc01yX8d7z3PF8F35U9AFkhh79lochXEv4MzEUhHcI4ym6tWxXVi5nFJV4bWtRRqYU4Mttx5bg3NQeIYMqKJMjSmH8CJBNG0H+nVwgazl/wac3RcT47ADE9TsYzFmkDUQQek65mZBEUi8NABwhqpZEFZqXRuWactb89X9CvMr6hFiUP8zU1yZ5GOEQpep/avmsuCLS3LQVqR1lvUuNUsxXNQvFLfKd0V9Ow== gavin@gav.local"
    ];
  };

  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
    swww # for wallpapers
    #xdg-desktop-portal-gtk
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ 22 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
