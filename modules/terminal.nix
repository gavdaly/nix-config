{ pkgs, ... }:

# TODO: Sort through these and remove the ones that are not needed
{
  environment.systemPackages = with pkgs; [
    upx
    git
    lazygit
    license-generator
    git-ignore
    pass-git-helper
    just
    xh
    tgpt
    # mcfly # terminal history
    zellij
    progress
    noti
    topgrade
    ripgrep
    rewrk
    wrk2
    procs
    tealdeer
    skim
    monolith
    aria
    macchina
    sd
    ouch
    duf
    du-dust
    fd
    jq
    gh
    trash-cli
    zoxide
    tokei
    fzf
    bat
    mdcat
    pandoc
    lsd
    lsof
    gping
    viu
    tre-command
    felix-fm
    chafa

    cmatrix
    pipes-rs
    rsclock
    cava
    figlet
  ];
}