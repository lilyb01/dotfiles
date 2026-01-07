{ config
, inputs
, pkgs
, lib
, ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  enabled = config.custom.desktop.hyprland;
in
{
  options.custom.desktop.hyprland = mkEnableOption "Hyprland desktop";

  config = mkIf enabled {
    environment.systemPackages = with pkgs; [
      hyprshot
      hyprpicker
      hypridle

      kdePackages.qt6ct
      kdePackages.qtmultimedia
      kdePackages.kirigami.unwrapped
      kdePackages.qtdeclarative
      kdePackages.sonnet
    ];
    qt.platformTheme = "qt5ct";
    services.xserver.enable = true;
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      package = pkgs.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
    programs.thunar.enable = true;
    programs.xfconf.enable = true;
    programs.thunar.plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
}
