{ config, inputs, lib, pkgs, ... }:
let
  cfg = config.custom.gamescope;
in
{
  options.custom.gamescope.enable = lib.mkEnableOption "steam gamescope";
  options.custom.steamdeck.enable = lib.mkEnableOption "steam deck";

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
        devices.steamdeck = lib.mkIf config.custom.steamdeck.enable {
            enable = true;
        };
    };

    environment.systemPackages = lib.mkIf config.custom.steamdeck.enable [
      pkgs.jupiter-dock-updater-bin
      pkgs.steamdeck-firmware
    ];
  };
}