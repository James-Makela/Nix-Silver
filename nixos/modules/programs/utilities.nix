{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Utilities
    cmake
    dconf
    gcc
    gnumake
    kdePackages.kdeconnect-kde
    nh
    pavucontrol
    unzip
    wget
    zip
    zsh
    deskflow
    lan-mouse
  ];
}
