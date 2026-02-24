{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gamemode
    linuxKernel.packages.linux_zen.xone
    lutris
    lsfg-vk
    lsfg-vk-ui
    mangohud
    opentrack
    pcsx2
    prismlauncher
    steamtinkerlaunch
    wine
    winetricks
    gpu-screen-recorder
  ];

  programs.java.enable = true;
  services.udev.packages = with pkgs; [ oversteer ];
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c266", RUN+="${pkgs.usb-modeswitch}/bin/usb_modeswitch -v 046d -p c261 -m 01 -r 01 -C 03 -M '0f00010142'"
  '';
  hardware.new-lg4ff.enable = true;
  hardware.logitech.wireless.enable = true;

  programs.steam = {
    enable = true;
    protontricks.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    gamescopeSession.enable = true;
  };
}
