{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      update = "nix flake update";
      upgrade = "sudo nixos-rebuild switch --flake .";
    };
    interactiveShellInit = ''
      eval "$(zoxide init zsh)"
    '';
  };

  environment.systemPackages = with pkgs; [
    # format nix packages 
    nixpkgs-fmt

    # Version management
    git

    # Github command line tool
    gh

    # Friendly and fast tool for sending HTTP requests
    xh

    # A command line tool for transferring files with URL syntax
    curl

    # Tool for retrieving files using HTTP, HTTPS, and FTP
    wget

    # A more modern http framework benchmark utility
    rewrk

    # A HTTP benchmarking tool based mostly on wrk
    wrk2

    # Bundle any web page into a single HTML file
    monolith

    # multi-protocol & multi-source, cross platform download utility
    aria2

    # Youtube downloader
    yt-dlp

    # Command Line Runner
    just

    # A workspace aimed at developers, ops-oriented people and anyone who loves the terminal. Similar programs are sometimes called "Terminal Multiplexers".
    zellij

    # Image viewer
    viu

    # Looks for coreutils basic commands (cp, mv, dd, tar, gzip/gunzip, cat, etc.) currently running on your system and displays the percentage of copied data. It can also show estimated time and throughput, and provides a "top-like" mode (monitoring).
    progress

    # A replacement for ps
    procs

    # System
    # A system information frontend
    macchina

    # Disk
    # Disk Usage/Free Utility
    duf

    # More intuitive du
    du-dust

    # a simple, fast, and featureful alternative to rm and trash-cli
    trashy

    # File
    # Search
    # A general fuzzy finder that saves you time
    skim

    # A fuzzy finder for your terminal
    fzf

    # A tui file manager with vim like key mapping
    felix-fm

    # A  program to find entries in your filesystem. It is a simple, fast and user-friendly alternative to 'find'
    fd

    # A smarter cd command
    zoxide

    # Line-oriented search tool that recursively searches the current directory for a regex pattern. By default, ripgrep will respect gitignore rules and automatically skip hidden files/directories and binary files.
    ripgrep

    # an intuitive find & replace CLI (sed alternative)
    sd

    # compressing and decompressing for various formats
    ouch

    # A program that displays statistics about your code
    tokei

    # An more userfriendly cat with syntax highlighting
    bat

    # cat for markdown
    mdcat

    # Universal markup converter
    pandoc

    # A modern replacement for 'ls'
    lsd

    # A command listing open files
    lsof

    # Ping, but with a graph
    gping

    # Tree command improved
    tre-command

    # information
    # A fast implementation of tldr
    tealdeer

    # tgpt is a cross-platform command-line interface (CLI) tool that allows you to use AI chatbot in your Terminal without requiring API keys.
    tgpt

    # Command Line JSON processor
    jq

    # Modern encryption tool with small explicit keys
    age

    # Simple and flexible tool for managing secrets
    sops
  ];
}
