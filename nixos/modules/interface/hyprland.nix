{ pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  environment.systemPackages = with pkgs; [
    hyprshade
    mako
    xdg-desktop-portal-hyprland
    waybar
    hyprpaper
    rofi
    blueberry
    nwg-look
    hyprcursor
    swww
    hyprpicker
  ];

  # Enable hyprland
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    hyprlock.enable = true;
  };

  # Enable hypridle
  services.hypridle.enable = true;
}
