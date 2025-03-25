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
      nix-direnv
      git
      vim
    ];

    # Enable zsh
    programs.zsh.enable = true;
    
    # Shell initialization for direnv and zoxide
    environment.interactiveShellInit = ''
      eval "$(direnv hook zsh)"
      eval "$(zoxide init zsh)"
    '';
    
    # Configure nix-direnv
    environment.pathsToLink = [
      "/share/nix-direnv"
    ];
    
    # Set up direnv configuration
    environment.etc."direnvrc".text = ''
      source ${pkgs.nix-direnv}/share/nix-direnv/direnvrc
      use_nix() {
        eval "$(${pkgs.nix-direnv}/bin/nix-direnv use "$@")"
      }
    '';
    
    # Ensure nix-darwin packages are in PATH
    environment.variables = {
      PATH = [ "/run/current-system/sw/bin" "$PATH" ];
    };
}