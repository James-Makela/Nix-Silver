{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Niri dependencies and other tools
    alacritty
    fuzzel
    swaybg
    swaylock
    swayidle
    xwayland-satellite
    xdg-desktop-portal-gtk
    impala
    # noctalia-shell
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    linux-wallpaperengine
    kdePackages.qttools
    pywalfox-native
    matugen
    khal
    # gpu-screen-recorder
    (inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override { calendarSupport = true; })
  ];

  # Enable niri
  programs = {
    niri = {
      enable = true;
    };
  };

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.gnome.evolution-data-server.enable = true;
  programs.evolution.enable = true;
}
