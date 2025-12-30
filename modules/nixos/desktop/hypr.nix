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
    services.xserver.enable = true;
    programs.hyprland = {
        enable = true;
        withUWSM = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    # TODO Implement a working config
  };
}
