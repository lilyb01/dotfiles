{ config, lib, ... }:
let
  cfg = config.custom.server.jellyseerr;
  port = 5055; # NOTE: not declaratively set...
in
{
  options.custom.server.jellyseerr = with lib; {
    enable = mkEnableOption "Jellyseerr";
  };

  config = lib.mkIf cfg.enable {
    services.jellyseerr = {
      enable = true;
      openFirewall = true;
      port = port;
    };

    services.nginx.virtualHosts = {
      "overseerr.${config.networking.domain}" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:${port}";
          extraConfig = 
            "proxy_ssl_server_name on;" +
            "proxy_pass_header Authorization;";
        };
      };
    };

  };
}