{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Hyprland dependencies and other tools
    adwaita-icon-theme
    kdePackages.filelight
    playerctl
    hyprshade
    # mako
    wireplumber
    freetype
    xdg-desktop-portal-hyprland
    waybar
    quickshell # trying this out
    hyprpaper
    rofi
    blueberry
    nwg-look
    libnotify
    hyprcursor
    libsecret
    brightnessctl
    wl-clipboard
    swww
    hyprpicker
    where-is-my-sddm-theme
    phinger-cursors
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
