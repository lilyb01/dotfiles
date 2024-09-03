{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib) mapAttrsToList mkIf mkOption types;
  cfg = config.custom.internet;
in
{
  options.custom.internet = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Internet Applications";
    };
    extras = mkOption {
      type = with lib.types; listOf package;
      description = "Extra Internet Applications";
      default = with pkgs; [
        ungoogled-chromium
        weechat
        vesktop
        telegram-desktop
        anydesk
        bitwarden-desktop
        nicotine-plus
        cinnamon.warpinator
        tigervnc
      ];
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      firefox-devedition
    ] ++ cfg.extras;
  };
}