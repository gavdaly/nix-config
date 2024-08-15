{ config, pkgs, ... }:

{
  # Home Manager settings for the macOS user
  home.username = "gavin";
  home.homeDirectory = "/Users/gavin";

  # Define the programs you want to manage with Home Manager
  programs.zsh.enable = true;
  programs.zsh.loginShell = true;

  programs.git = {
    enable = true;
    userName = "Gavin";          # Replace with your Git username
    userEmail = "gavin@gavdev.xyz";  # Replace with your Git email

    extraConfig = {
      # Aliases
      "alias.co" = "checkout";
      "alias.br" = "branch";
      "alias.ci" = "commit";
      "alias.st" = "status";
      "alias.last" = "log -1 HEAD";
      
      # Set default branch name to 'main'
      "init.defaultBranch" = "main";

      # Push default configuration
      "push.default" = "simple";

      # Set the default editor to Neovim
      "core.editor" = "nvim";
      
      # Color configuration
      "color.ui" = "auto";
      
      # Credential caching
      "credential.helper" = "osxkeychain";

      # Enable rebasing by default for pull
      "pull.rebase" = "true";
    };
  };

  # Installing `eza` as a replacement for `ls`, with colors, icons, and git status
  programs.eza = {
    enable = true;
    alias = "ls";  # Optionally alias `eza` to `ls`
    options = [
      "--color=always"
      "--icons"
      "--git"  # Enable git status information in file listings
    ];
  };

  # Adding a custom alias for `eza` with `-la` flags
  programs.zsh = {
    enable = true;
    aliases = {
      l = "eza -la --color=always --icons --git";
    };
  };

  # Recommended additional programs
  programs.bat.enable = true;
  programs.ripgrep.enable = true;
  programs.htop.enable = true;
  programs.fd.enable = true;
  programs.tldr.enable = true;
  programs.delta.enable = true;

  # Installing and configuring `zellij`
  programs.zellij.enable = true;

  # Installing and configuring `devenv`
  programs.devenv = {
    enable = true;
  };

  # Installing `zoxide`
  programs.zoxide.enable = true;

  # Installing `fzf`
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;  # Enable fzf integration with zsh
    keybindings = {
      "ctrl-r" = "history search";
      "alt-c" = "cd to directory";
      "ctrl-t" = "open file";
    };
  };

  # Installing and configuring nix-direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    extraInit = ''
      use nix
    '';
  };

  # Installing command-line utilities including GitHub CLI
  home.packages = with pkgs; [
    jq
    curl
    wget
    gh  # GitHub CLI
  ];

  # Set up neovim as your editor
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set number
      syntax on
    '';
  };
}
