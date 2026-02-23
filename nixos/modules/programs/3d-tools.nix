{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # 3D Tools
    kicad
    blender
  ];
}
