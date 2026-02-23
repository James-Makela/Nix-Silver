{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    btop
    cava
    direnv
    dysk
    eza
    fastfetch
    fd
    fortune
    fzf
    home-manager
    nix-search-tv
    oh-my-zsh
    ripgrep
    shellcheck
    sshfs
    sway-contrib.grimshot
    timg
    tealdeer
    tmux
    traceroute
    tree
    wiremix
    yazi
    zplug
    zsh-powerlevel10k
  ];
}
