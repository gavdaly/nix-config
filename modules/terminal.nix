{ pkgs, ... }:

# TODO: Sort through these and remove the ones that are not needed
{
  environment.systemPackages = with pkgs; [
# Version Control
    # Version management
    git
    
    # Github command line tool
    gh

# HTTP Utilities
    # Friendly and fast tool for sending HTTP requests
    xh
    # A command line tool for transferring files with URL syntax
    curl
    # Tool for retrieving files using HTTP, HTTPS, and FTP
    wget

# Shell Utilities
    # Command Line Runner
    just

    # tgpt is a cross-platform command-line interface (CLI) tool that allows you to use AI chatbot in your Terminal without requiring API keys.
    # tgpt
    
    # A workspace aimed at developers, ops-oriented people and anyone who loves the terminal. Similar programs are sometimes called "Terminal Multiplexers".
    zellij

    # Looks for coreutils basic commands (cp, mv, dd, tar, gzip/gunzip, cat, etc.) currently running on your system and displays the percentage of copied data. It can also show estimated time and throughput, and provides a "top-like" mode (monitoring).
    # progress

    # Monitor a process and trigger a notification 
    # not terminal only
    # noti

    # Detects which tools you use and runs the appropriate commands to update them
    # topgrade

    # Line-oriented search tool that recursively searches the current directory for a regex pattern. By default, ripgrep will respect gitignore rules and automatically skip hidden files/directories and binary files.
    ripgrep

    # A more modern http framework benchmark utility
    rewrk

    # A HTTP benchmarking tool based mostly on wrk
    wrk2

    # A replacement for ps
    procs

    # A fast implementation of tldr
    tealdeer

    # A general fuzzy finder that saves you time
    skim

    # Bundle any web page into a single HTML file
    monolith

    # multi-protocol & multi-source, cross platform download utility
    aria
    
    # A system information frontend
    macchina

    # an intuitive find & replace CLI (sed alternative)
    sd

    # compressing and decompressing for various formats
    ouch

    # Disk Usage/Free Utility
    duf

    # More intuitive du
    du-dust
    
    # A  program to find entries in your filesystem. It is a simple, fast and user-friendly alternative to 'find'
    fd

    # Command Line JSON processor
    jq

    # a simple, fast, and featureful alternative to rm and trash-cli
    trashy

    # A smarter cd command
    zoxide

    # A program that displays statistics about your code
    tokei
    
    # A fuzzy finder for your terminal
    fzf

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

    # Image viewer
    viu

    # Tree command improved
    tre-command

    # A tui file manager with vim like key mapping
    felix-fm

    # Terminal graphics
    chafa

    # The Matrix in your terminal
    cmatrix

    # Terminal screensaver of pipes
    pipes-rs

    # A simple terminal clock
    rsclock

    # Audio visualizer
    cava

    # Make large letters out of ordinary text
    figlet
  ];
}