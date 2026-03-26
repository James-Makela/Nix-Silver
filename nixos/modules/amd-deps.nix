{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    egl-wayland
    mesa
    lm_sensors
  ];

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.amdgpu.initrd.enable = true; # sets boot.initrd.kernelModules = ["amdgpu"];

}
