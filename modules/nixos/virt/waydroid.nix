{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  enabled = config.custom.virt.waydroid.enable;
in
{
  options.custom.virt.waydroid.enable = mkEnableOption "Waydroid";

  config = mkIf enabled {
    virtualisation.waydroid.enable = true;
  };
}