{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Communication
    discord
    localsend
    obs-studio
    # rustdesk
    signal-desktop
    slack
  ];
}
