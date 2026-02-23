{ inputs, pkgs, ... }:

{
  # ============================================================================
  # IMPORTS
  # ============================================================================

  imports = 
    [
      ./programs/media.nix
      ./programs/utilities.nix
      ./programs/default.nix
      ./programs/communication.nix
      ./programs/terminal-tools.nix
    ];

  # ==========================================================================
  # BOOTLOADER
  # ==========================================================================

  boot = {
    loader = {
      systemd-boot.enable = true;
      systemd-boot.consoleMode = "max";
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
    initrd.systemd.enable = true;
    initrd.verbose = false;
    consoleLogLevel = 0;
    plymouth = {
      enable = true;
      theme = "bgrt";
    };
  };

  security.polkit.enable = true;

  # ============================================================================
  # NIX SETTINGS
  # ============================================================================

  nix.gc = {
    automatic = true;
    dates = "weekly";
    persistent = true;
    options = "--delete-older-than 30d";
  };

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

  # ============================================================================
  # LOCALE SETTINGS
  # ============================================================================

  # Set your time zone.
  time.timeZone = "Australia/Perth";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # ============================================================================
  # KEYMAP
  # ============================================================================

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  # ============================================================================
  # SHELL
  # ============================================================================

  # Set zsh to be default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
