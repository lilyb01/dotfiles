{ config, lib, pkgs, ... }:
let
  cfg = config.custom.gaming;
in
{
  options.custom.gaming.enable = lib.mkEnableOption "gaming";

  config = lib.mkIf cfg.enable {
    hardware.graphics.enable = true;

    programs.steam = {
      enable = true;
      # package = pkgs.steamPackages.steam;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        protontricks
      ];
    };

#    programs.nix-ld = {
#      enable = true;
#      libraries = pkgs.steam-run.fhsenv.args.multiPkgs pkgs;
#    };

    environment.systemPackages = with pkgs; [
      xivlauncher
      prismlauncher
      steam-run
      r2modman
    ];

    nixpkgs.config.allowUnfreePredicate = pkg: lib.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-run"
    ];
  };
}
