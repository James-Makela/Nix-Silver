{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    where-is-my-sddm-theme
  ];

  services.displayManager.sddm = {
    enable = true;
    enableHidpi = false;
    autoNumlock = true;
    extraPackages = with pkgs; [qt6.qt5compat];
    settings = {
      Theme = {
        Current = "where_is_my_sddm_theme";
      };
    };
  };
}
