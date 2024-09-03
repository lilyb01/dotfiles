{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib) mapAttrsToList mkIf mkOption types;
  cfg = config.custom.wine;
in
{
  options.custom.wine = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Wine Applications";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bottles
    ];
  };
}