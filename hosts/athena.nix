{ pkgs, ... }:

{
    # Basic system packages
    environment.systemPackages = with pkgs; [
      bat
      ripgrep
      btop 
      devenv
      zoxide
      direnv
    ];

    # The following programs.* configurations won't work without Home Manager
    # programs.devenv.enable = true;
    # programs.zoxide.enable = true;
    # programs.direnv = {
    #   enable = true;
    #   nix-direnv.enable = true;
    #   extraInit = ''
    #     use nix
    #   '';
    # };

    # If you're using zsh, you might want this instead
    environment.interactiveShellInit = ''
      eval "$(direnv hook zsh)"
      eval "$(zoxide init zsh)"
    '';
}