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
      enable = true;
      after = [ "network.target" ];
      wantedBy = [ "default.target" ];
      description = "Plex Discord Rich Presence";
      serviceConfig = {
          User = "lily";
          Type = "simple";
          WorkingDirectory = "/home/lily/nix-config-old/home/plexrpc/";
          ExecStart = ''/home/lily/nix-config-old/home/plexrpc/venv/bin/python3 main.py'';
      };
    };
    
  };
}