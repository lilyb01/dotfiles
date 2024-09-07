# The total autonomous media delivery system.
# Relevant link [1].
#
# [1]: https://youtu.be/I26Ql-uX6AM
{ config, lib, ... }:
let
  cfg = config.custom.server.servarr;

  ports = {
    prowlarr = 9696;
    bazarr = 6767;
    lidarr = 8686;
    radarr = 7878;
    sonarr = 8989;
  };

  mkService = service: {
    services.${service} = {
      enable = true;
      #group = "media";
    };
  };

  mkRedirection = service: {
    services.nginx.virtualHosts = {
      "${service}.${config.networking.domain}" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:" + toString ports.${service};
          extraConfig = 
            "proxy_ssl_server_name on;" +
            "proxy_pass_header Authorization;";
        };
      };
    };
  };

  mkFail2Ban = service: lib.mkIf cfg.${service}.enable {
    services.fail2ban.jails = {
      ${service} = ''
        enabled = true
        filter = ${service}
        action = iptables-allports
      '';
    };

    environment.etc = {
      "fail2ban/filter.d/${service}.conf".text = ''
        [Definition]
        failregex = ^.*\|Warn\|Auth\|Auth-Failure ip <HOST> username .*$
        journalmatch = _SYSTEMD_UNIT=${service}.service
      '';
    };
  };

  mkFullConfig = service: lib.mkIf cfg.${service}.enable (lib.mkMerge [
    (mkService service)
    #(mkRedirection service)
  ]);
in
{
  options.custom.server.servarr = {
    enable = lib.mkEnableOption "Media automation with Servarr suite";

    prowlarr = {
      enable = lib.mkEnableOption "Media automation with Servarr suite";
    };

    bazarr = {
      enable = lib.mkEnableOption "Media automation with Servarr suite";
    };

    lidarr = {
      enable = lib.mkEnableOption "Media automation with Servarr suite";
    };

    radarr = {
      enable = lib.mkEnableOption "Media automation with Servarr suite";
    };

    sonarr = {
      enable = lib.mkEnableOption "Media automation with Servarr suite";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      # Set-up media group
      users.groups.media = { };

      # TODO make this dependant on what's actually enabled. or just disable this and use nginx ig.
      networking.firewall.allowedTCPPorts = [ 9696 6767 8686 7878 8989 ];
    }
    # Bazarr does not log authentication failures...
    (mkFullConfig "bazarr")
    # Lidarr for music
    (mkFullConfig "lidarr")
    (mkFail2Ban "lidarr")
    # Radarr for movies
    (mkFullConfig "radarr")
    (mkFail2Ban "radarr")
    # Sonarr for shows
    (mkFullConfig "sonarr")
    (mkFail2Ban "sonarr")
    # Prowlarr for indexing
    (mkFullConfig "prowlarr")
    #i haven't checked if prowlarr logs auth fails or not :/
  ]);
}