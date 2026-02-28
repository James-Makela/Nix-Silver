{ inputs, pkgs, lib, ... }:

{
  # ============================================================================
  # IMPORTS
  # ============================================================================

  imports = [
      ./hardware-configuration.nix
      ../../modules/common.nix
      ../../modules/programs/qemu.nix
      ../../modules/programs/communication.nix
      ../../modules/programs/gaming.nix
      ../../modules/programs/development.nix
      ../../modules/amd-deps.nix
      ../../modules/programs/media.nix
      ../../modules/programs/3d-tools.nix
      ../../modules/programs/productivity.nix
      ../../modules/interface/sddm.nix
      ../../modules/interface/niri.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  # ============================================================================
  # HOST IDENTIFICATION
  # ============================================================================

  networking.hostName = "Desktop";
  users.motd = "Welcome to Desktop";

  # ============================================================================
  # NETWORKING
  # ============================================================================

  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";
  networking.dhcpcd.extraConfig = "nohook resolv.conf";

  services.fail2ban.enable = true;
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
    };
  };

  networking.nameservers = [ ];

  services.mullvad-vpn.enable = true;
  services.tailscale = { enable = true ; };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];


  # ============================================================================
  # ENVIRONMENT VARIABLES
  # ============================================================================

  # Electron on wayland fix for scaling issues
  # TODO: Make this global
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # ============================================================================
  # HARDWARE SETTINGS
  # ============================================================================

  hardware.xone.enable = true;

  # Enable QMK keyboard configuration
  hardware.keyboard.qmk.enable = true;
  services.udev = {
    packages = with pkgs; [
      qmk
      qmk-udev-rules
      qmk_hid
      via
      vial
    ];
  };

  services.xserver.enable = true;

  # ============================================================================
  # DEVICES
  # ============================================================================

  services.printing.enable = true;

  # ============================================================================
  # AUDIO
  # ============================================================================

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # ============================================================================
  # USER MANAGEMENT
  # ============================================================================
  
  # TODO: Get all user management into one place
  users.users.user = {
    isNormalUser = true;
    description = "User";
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
    ];
    # TODO: Move these elsewhere
    packages = with pkgs; [
      firefox
      thunderbird
    ];
  };

  # ============================================================================
  # FONTS
  # ============================================================================

  # Allow installation of unfree corefonts package
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ 
    "corefonts"
    "cjkfonts"
    "steam"
    "steam-original"
    "steam-run"
  ];

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

  # ============================================================================
  # MOUNT POINTS
  # ============================================================================

  fileSystems."/run/media/games" = {
    device = "UUID=dc97e98d-a017-4234-8d76-551bb484a1f0";
    fsType = "ext4";
  };

}
