{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
  niri
  alacritty
	];
}
