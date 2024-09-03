{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  enabled = config.custom.server.nfs.enable;
in
{
  options.custom.server.nfs = {
    enable = mkEnableOption "NFS";
    shares = lib.mkOption {
      type = with lib.types; listOf str;
      description = "NFS shares to enable";
    };
  };

  config = mkIf enabled {
    services.nfs.server.enable = true;
    services.nfs.server.exports = config.custom.server.nfs.shares;
    networking.firewall.allowedTCPPorts = [ 2049 ]; 
  };
}