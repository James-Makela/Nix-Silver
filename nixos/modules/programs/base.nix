{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
    cataclysm-dda-git
	];
}
