# Usenet binary client.
{ config, lib, ... }:
let
  cfg = config.custom.server.pms;
  port = 32400; # NOTE: not declaratively set...
in
{
  options.custom.server.pms = with lib; {
    enable = mkEnableOption "Plex Media Server";
  };

  config = lib.mkIf cfg.enable {
    services.plex = {
      enable = true;
      dataDir = "/var/lib/plex";
      openFirewall = true;
      user = "plex";
      group = "plex";
    };

    services.nginx.virtualHosts = {
      "plex.${config.networking.domain}" = {
        enableACME = false; # TODO
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString port}";
          extraConfig = 
            "proxy_ssl_server_name on;" +
            "proxy_pass_header Authorization;";
        };
      };
    };

  };
}