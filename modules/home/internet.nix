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
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      firefox-devedition
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
}