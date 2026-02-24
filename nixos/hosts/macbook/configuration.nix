{ config, lib, pkgs, ... }:

{
  # ============================================================================
  # IMPORTS
  # ============================================================================

  imports = [
      ./hardware-configuration.nix
      # Include the necessary packages and configuration for Apple Silicone support
      ./apple-silicon-support
      # We cannot import common at this time due to the EFIVariables setting
      # Instead we import what that imports
      ../../modules/programs/utilities.nix
      ../../modules/programs/default.nix
      ../../modules/programs/terminal-tools.nix
      ../../modules/programs/development.nix
      ../../modules/programs/productivity.nix
      # ../../modules/interface/hyprland.nix
      ../../modules/interface/sddm.nix
      ../../modules/interface/niri.nix
    ];

  # ============================================================================
  # BOOTLOADER
  # ============================================================================

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  # ============================================================================
  # HOST IDENTIFICATION
  # ============================================================================

  networking.hostName = "MacBook"; # Define your hostname.

  # ============================================================================
  # HOST IDENTIFICATION
  # ============================================================================

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # ============================================================================
  # NETWORKING
  # ============================================================================

  networking.networkmanager.enable = true;

  # networking.wireless.iwd = {
  #   enable = true;
  #   settings.General.EnableNetworkConfiguration = true;
  # };

  services.tailscale.enable = true;

  networking.firewall.allowedTCPPorts = [ 45000 ];

  # ============================================================================
  # FIRMWARE SETTINGS
  # ============================================================================

  hardware.asahi.peripheralFirmwareDirectory = ./firmware;
  hardware.asahi.setupAsahiSound = true;

  # ============================================================================
  # HARDWARE SETTINGS
  # ============================================================================

  hardware.apple.touchBar = {
    enable = true;
    package = pkgs.tiny-dfr;
    settings = {
      MediaLayerDefault = true;
    };
  };

  hardware.bluetooth.enable = true;

  services.xserver.enable = true;

  # ============================================================================
  # USER MANAGEMENT
  # ============================================================================

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user = {
    isNormalUser = true;
    description = "User";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
      firefox
    ];
  };

  # ============================================================================
  # PROGRAMS - this can be removed once home-manager is sorted
  # ============================================================================

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
  ];

  programs.git = {
    enable = true;
    config = {
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
    };
  };

  # ============================================================================
  # FONTS
  # ============================================================================

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

  security.polkit.enable = true;

  # ============================================================================
  # SYSTEM
  # ============================================================================

  system.stateVersion = "25.11"; # Did you read the comment?

}

