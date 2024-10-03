{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib) mapAttrsToList mkIf mkOption types;
  cfg = config.custom.plexrpc;
in
{
  options.custom.plexrpc = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Media Applications";
    };
  };

  config = mkIf cfg.enable {

    systemd.user.services.plexrpc = {
      Unit.Description = "Plex Discord Rich Presence";
      Install = {
        WantedBy = [ "default.target" ];
      };
      Service = {
          WorkingDirectory = "/home/lily/nix-config-old/home/plexrpc/";
          ExecStart = ''/home/lily/nix-config-old/home/plexrpc/venv/bin/python3 main.py'';
          Restart = "on-failure";
      };
    };
    
  };
}