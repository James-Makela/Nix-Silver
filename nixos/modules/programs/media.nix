{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Media
    plexamp
    mpv
    radiotray-ng
  ];
}
