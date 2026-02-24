{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
    libnotify
    kdePackages.qttools
    adwaita-icon-theme
    kdePackages.filelight
    playerctl
    wireplumber
    freetype
    libsecret
    brightnessctl
    wl-clipboard
    phinger-cursors
  ];
}
