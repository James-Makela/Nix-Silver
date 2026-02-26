{
  description = "Nixos config flake";

  # ============================================================================
  # INPUTS
  # ============================================================================
  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-25.11"; };
    nixpkgs-unstable = { url = "github:nixos/nixpkgs/nixos-unstable"; };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # ============================================================================
  # OUTPUTS
  # ============================================================================
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {

      # ========================================================================
      # LAPTOP
      # ========================================================================
      nixosConfigurations.default = nixpkgs-unstable.lib.nixosSystem {
        specialArgs = { inherit inputs system; };
        modules = [
          ./hosts/default/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.user = import ./home-manager;
          }
        ];
      };

      # ========================================================================
      # DESKTOP
      # ========================================================================
      nixosConfigurations.desktop = nixpkgs-unstable.lib.nixosSystem {
        specialArgs = { inherit inputs system; };
        modules = [
          ./hosts/desktop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.user = import ./home-manager;
          }
        ];
      };

      # ========================================================================
      # MACBOOK
      # ========================================================================
      nixosConfigurations.macbook = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/macbook/configuration.nix
        ];
      };
    };
}
