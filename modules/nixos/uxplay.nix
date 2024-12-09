{ config, lib, pkgs, ... }:
let
  cfg = config.custom.uxplay;
in
{
  options.custom.uxplay = {
    enable = lib.mkEnableOption "uxplay";
  };

  config = lib.mkIf cfg.enable {
    services.avahi = {
      nssmdns4 = true;
      enable = true;
      publish = {
        enable = true;
        userServices = true;
        domain = true;
      };
    };
    environment.systemPackages = with pkgs; [
        uxplay
    ];
  };
}