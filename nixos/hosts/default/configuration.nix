{ inputs, pkgs, lib, ... }:

{
  # ============================================================================
  # IMPORTS
  # ============================================================================

  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/common.nix
    ../../modules/programs/base.nix
    ../../modules/programs/communication.nix
    ../../modules/programs/media.nix
    ../../modules/programs/development.nix
    ../../modules/programs/productivity.nix
    # ../../modules/interface/hyprland.nix
    ../../modules/interface/sddm.nix
    ../../modules/interface/niri.nix

    ../../modules/testing.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  # ============================================================================
  # SWAP
  # ============================================================================

  swapDevices = lib.mkForce [ ];

  # ============================================================================
  # HOST IDENTIFICATION
  # ============================================================================

  networking.hostName = "Laptop";
  users.motd = "Welcome to Laptop";

  # ============================================================================
  # NETWORKING - Module
  # ============================================================================

  networking.networkmanager.enable = true;

  services.mullvad-vpn = { enable = true; };

  services.tailscale = { enable = true; };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];

  networking.nameservers = ["192.168.0.50"];

  # ============================================================================
  # ENVIRONMENT VARIABLES - COMMON
  # ============================================================================

  environment.sessionVariables = { 
    NIXOS_OZONE_WL = "1";
  };

  # ============================================================================
  # HARDWARE SETTINGS
  # ============================================================================

  ## Fixes Sleep issues
  # https://discourse.nixos.org/t/weird-behaviour-after-suspend-gnome/38210/6
  systemd.services."pre-sleep".wantedBy = lib.mkForce [ ];


  services = {
    xserver = {
      enable = true;
      # videoDrivers = [ "displaylink" ];
    };
  };

  # ============================================================================
  # DEVICES
  # ============================================================================

  # TODO: Move Bluetooth to Audio - then Make a printing Module

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    settings = { General = { Experimental = "true"; }; };
  };

  # ============================================================================
  # AUDIO
  # ============================================================================

  # TODO: Make this into a module imported by common

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # ============================================================================
  # USER MANAGEMENT
  # ============================================================================

  users.users.user = {
    isNormalUser = true;
    description = "User";
    extraGroups = [ "networkmanager" "wheel" "docker" "dialout" ];
    packages = with pkgs; [ firefox thunderbird ];
  };

  # ============================================================================
  # FONTS
  # ============================================================================

  # This should be split - top half to stay - bottom half to modularise out

  # Allow installation of unfree corefonts packaged
  nixpkgs.config.allowUnfreePredicate = pkg:
  builtins.elem (lib.getName pkg) [ "corefonts" ];

  fonts.packages = with pkgs; [
    corefonts
    fira-code
    fira-code-symbols
    nerd-fonts.hack
    font-awesome
    meslo-lgs-nf
  ];

  # ============================================================================
  # TODO: Sort these out
  # ============================================================================

  # List services that you want to enable:
  services.gnome.gnome-keyring.enable = true;

  # ============================================================================
  # SYSTEM
  # ============================================================================

  system.stateVersion = "23.11";
}
