# Example devenv.nix template
{ pkgs, ... }:

{
  # Enable devenv options
  enable = true;

  # Packages installed in the environment
  packages = with pkgs; [
    git
    ripgrep
    fd
  ];

  # Languages and their configurations
  languages = {
    # Example Rust configuration
    rust = {
      enable = true;
      # version = "stable";
      # components = [ "rustc" "cargo" "clippy" "rustfmt" "rust-analyzer" ];
    };

    # Example Node.js configuration
    nodejs = {
      enable = false;
      # version = "18";
      # package = pkgs.nodejs_18;
    };

    # Example Python configuration
    python = {
      enable = false;
      # version = "3.11";
      # packages = ps: with ps; [ 
      #   requests 
      #   pytest
      # ];
    };

    # Example Go configuration
    go = {
      enable = false;
      # version = "1.21";
    };
  };

  # Scripts available in the environment
  scripts = {
    test.exec = "echo 'Running tests...'";
    lint.exec = "echo 'Running linter...'";
    build.exec = "echo 'Building project...'";
  };

  # Pre-commit hooks
  pre-commit.hooks = {
    nixpkgs-fmt.enable = true;
    shellcheck.enable = true;
  };

  # Environment variables
  env = {
    EXAMPLE_VAR = "example_value";
  };

  # Processes to run in the environment
  processes = {
    # Example development server
    dev.exec = "echo 'Starting development server...'";
  };

  # Enter environment hook
  enterShell = ''
    echo "Welcome to the development environment!"
  '';
}