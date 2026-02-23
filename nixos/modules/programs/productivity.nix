{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Productivity
    libreoffice-fresh
    obsidian
    neomutt # Tui email client
  ];
}
