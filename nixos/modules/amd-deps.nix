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
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      intel-ocl
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

  hardware.amdgpu.initrd.enable = true; # sets boot.initrd.kernelModules = ["amdgpu"];

}
