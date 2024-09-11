{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  enabled = config.custom.server.samba.enable;
in
{
  options.custom.server.samba = {
    enable = mkEnableOption "Samba";
    shares = lib.mkOption {
      type = with lib.types; attrsOf attrs;
      description = "Samba shares to enable";
    };
  };

  config = mkIf enabled {
    services.samba = {
        enable = true;
        securityType = "user";
        openFirewall = true;
        settings.global = {
            workgroup = "WORKGROUP";
            "server string" = "${config.networking.hostName}";
            "netbios name" = "${config.networking.hostName}";
            security = "user";
            #use sendfile = yes
            #max protocol = smb2
            # note: localhost is the ipv6 localhost ::1
            "hosts allow" = "192.168.0. 127.0.0.1 10.4.21. localhost";
            "hosts deny" = "0.0.0.0/0";
            "guest account" = "nobody";
            "map to guest" = "bad user";
        };
        shares = config.custom.server.samba.shares;
    };

    services.samba-wsdd = {
        enable = true;
        openFirewall = true;
    };

  };
}