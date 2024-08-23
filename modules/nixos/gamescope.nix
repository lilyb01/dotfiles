{ config, inputs, lib, pkgs, ... }:
let
  cfg = config.custom.gamescope;
  cfgdeck = config.custom.steamdeck;
  cfgloader = config.custom.deckyloader;
in
{
  options.custom.gamescope.enable = lib.mkEnableOption "steam gamescope";
  options.custom.steamdeck.enable = lib.mkEnableOption "steam deck";
  options.custom.deckyloader.enable = lib.mkEnableOption "decky loader";

  imports = [
    inputs.jovian.nixosModules.default
  ];

  config = lib.mkIf cfg.enable {

    services.xserver.displayManager.gdm.enable = lib.mkForce false;

    services.xserver.displayManager.autoLogin.enable = true;
    services.xserver.displayManager.autoLogin.user = "lily";

    jovian = {
        steam = { 
            enable = true;
            autoStart = true;
            user = "lily";
            desktopSession = "gnome";
        };
        devices.steamdeck = lib.mkIf cfgdeck.enable {
            enable = true;
        };
        decky-loader = lib.mkIf cfgloader.enable {
          enable = true;
        };
    };

    environment.systemPackages = lib.mkIf cfgdeck.enable [
      pkgs.jupiter-dock-updater-bin
      pkgs.steamdeck-firmware
    ];
  };
}