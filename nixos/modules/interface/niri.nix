{ pkgs, inputs, ... }:

{
  imports = 
    [
      ./common.nix
    ];

  environment.systemPackages = with pkgs; [
    swaylock
    xwayland-satellite
    xdg-desktop-portal-gtk
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    pywalfox-native
    matugen
    (inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override { calendarSupport = true; })
  ];

  programs = {
    niri = {
      enable = true;
    };
  };

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
}
