{ config, lib, pkgs, ... }:
let
  cfg = config.custom.uxplay;
in
{
  options.custom.uxplay = {
    enable = lib.mkEnableOption "uxplay";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
        uxplay
    ];
  };
}