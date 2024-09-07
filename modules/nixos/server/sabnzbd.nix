# Usenet binary client.
{ config, lib, ... }:
let
  cfg = config.custom.server.sabnzbd;
  port = 8080; # NOTE: not declaratively set...
in
{
  options.custom.server.sabnzbd = with lib; {
    enable = mkEnableOption "SABnzbd binary news reader";
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ port ];
    services.sabnzbd = {
      enable = true;
      group = "media";
    };

    # Set-up media group
    users.groups.media = { };

    services.nginx.virtualHosts = {
      "sabnzbd.${config.networking.domain}" = {
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

    services.fail2ban.jails = {
      sabnzbd = ''
        enabled = true
        filter = sabnzbd
        port = http,https
        # Unfortunately, sabnzbd does not log to systemd journal
        backend = auto
        logpath = /var/lib/sabnzbd/logs/sabnzbd.log
      '';
    };

    environment.etc = {
      # FIXME: path to log file
      "fail2ban/filter.d/sabnzbd.conf".text = ''
        [Definition]
        failregex = ^.*WARNING.*API Key incorrect, Use the api key from Config->General in your 3rd party program: .* \(X-Forwarded-For: <HOST>\) .*$
                    ^.*WARNING.*API Key incorrect, Use the api key from Config->General in your 3rd party program: <HOST> .*$
                    ^.*WARNING.*API Key missing, please enter the api key from Config->General into your 3rd party program: .* \(X-Forwarded-For: <HOST>\) .*$
                    ^.*WARNING.*API Key missing, please enter the api key from Config->General into your 3rd party program: <HOST> .*$
                    ^.*WARNING.*Refused connection from: .* \(X-Forwarded-For: <HOST>\) .*$
                    ^.*WARNING.*Refused connection from: <HOST> .*$
                    ^.*WARNING.*Refused connection with hostname ".*" from: .* \(X-Forwarded-For: <HOST>\) .*$
                    ^.*WARNING.*Refused connection with hostname ".*" from: <HOST> .*$
                    ^.*WARNING.*Unsuccessful login attempt from .* \(X-Forwarded-For: <HOST>\) .*$
                    ^.*WARNING.*Unsuccessful login attempt from <HOST> .*$
        journalmatch = _SYSTEMD_UNIT=sabnzbd.service
      '';
    };
  };
}