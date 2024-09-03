# A simple abstraction layer for almost all of my services' needs
{ config, lib, pkgs, ... }:
let
  cfg = config.custom.server.nginx;

  domain = config.networking.domain;

  virtualHostOption = with lib; types.submodule ({ name, ... }: {
    options = {
      subdomain = mkOption {
        type = types.str;
        default = name;
        example = "dev";
        description = ''
          Which subdomain, under config.networking.domain, to use
          for this virtual host.
        '';
      };

      port = mkOption {
        type = with types; nullOr port;
        default = null;
        example = 8080;
        description = ''
          Which port to proxy to, through 127.0.0.1, for this virtual host.
        '';
      };

      redirect = mkOption {
        type = with types; nullOr str;
        default = null;
        example = "https://example.com";
        description = ''
          Which domain to redirect to (301 response), for this virtual host.
        '';
      };

      root = mkOption {
        type = with types; nullOr path;
        default = null;
        example = "/var/www/blog";
        description = ''
          The root folder for this virtual host.
        '';
      };

      socket = mkOption {
        type = with types; nullOr path;
        default = null;
        example = "FIXME";
        description = ''
          The UNIX socket for this virtual host.
        '';
      };

      sso = {
        enable = mkEnableOption "SSO authentication";
      };

      extraConfig = mkOption {
        type = types.attrs; # FIXME: forward type of virtualHosts
        example = litteralExample ''
          {
            locations."/socket" = {
              proxyPass = "http://127.0.0.1:8096/";
              proxyWebsockets = true;
            };
          }
        '';
        default = { };
        description = ''
          Any extra configuration that should be applied to this virtual host.
        '';
      };
    };
  });
in
{

    imports = [
        #../../../lib/attrs.nix
        #../../../lib/lists.nix
    ];

  options.custom.server.nginx = with lib; {
    enable = mkEnableOption "Nginx";

    acme = {
      credentialsFile = mkOption {
        type = types.str;
        example = "/var/lib/acme/creds.env";
        description = ''
          Gandi API key file as an 'EnvironmentFile' (see `systemd.exec(5)`)
        '';
      };
    };

    virtualHosts = mkOption {
      type = types.attrsOf virtualHostOption;
      default = { };
      example = litteralExample ''
        {
          gitea = {
            subdomain = "git";
            port = 8080;
          };
          dev = {
            root = "/var/www/dev";
          };
          jellyfin = {
            port = 8096;
            extraConfig = {
              locations."/socket" = {
                proxyPass = "http://127.0.0.1:8096/";
                proxyWebsockets = true;
              };
            };
          };
        }
      '';
      description = ''
        List of virtual hosts to set-up using default settings.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [ ]
      ++ (lib.flip lib.mapAttrsToList cfg.virtualHosts (_: { subdomain, ... } @ args:
      let
        conflicts = [ "port" "root" "socket" "redirect" ];
        optionsNotNull = builtins.map (v: args.${v} != null) conflicts;
        optionsSet = lib.filter lib.id optionsNotNull;
      in
      {
        assertion = builtins.length optionsSet == 1;
        message = ''
          Subdomain '${subdomain}' must have exactly one of ${
            lib.concatStringsSep ", " (builtins.map (v: "'${v}'") conflicts)
          } configured.
        '';
      }));

    services.nginx = {
      enable = true;
      statusPage = true; # For monitoring scraping.

      recommendedBrotliSettings = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      recommendedZstdSettings = true;

      #virtualHosts =
      #  let
      #    domain = config.networking.domain;
      #    mkVHost = ({ subdomain, ... } @ args: lib.nameValuePair
      #      "${subdomain}.${domain}"
      #      (lib.foldl lib.recursiveUpdate [
      #        # Base configuration
      #        {
      #          forceSSL = true;
      #          useACMEHost = domain;
      #        }
      #        # Proxy to port
      #        (lib.optionalAttrs (args.port != null) {
      #          locations."/".proxyPass =
      #            "http://127.0.0.1:${toString args.port}";
      #        })
      #        # Serve filesystem content
      #        (lib.optionalAttrs (args.root != null) {
      #          inherit (args) root;
      #        })
      ##        # Serve to UNIX socket
      #         (lib.optionalAttrs (args.socket != null) {
      #          locations."/".proxyPass =
      #            "http://unix:${args.socket}";
      #        })
      #        # Redirect to a different domain
      ##        (lib.optionalAttrs (args.redirect != null) {
       #         locations."/".return = "301 ${args.redirect}$request_uri";
       #       })
       #       # VHost specific configuration
       #       args.extraConfig
       #       # SSO configuration
       #       (lib.optionalAttrs args.sso.enable {
       #         extraConfig = (args.extraConfig.extraConfig or "") + ''
       #           error_page 401 = @error401;
       #         '';

       #         locations."@error401".return = ''
       #           302 https://${cfg.sso.subdomain}.${config.networking.domain}/login?go=$scheme://$http_host$request_uri
       #         '';

       #         locations."/" = {
       #           extraConfig =
       #             (args.extraConfig.locations."/".extraConfig or "") + ''
       #               # Use SSO
       #               auth_request /sso-auth;

       #               # Set username through header
       #               auth_request_set $username $upstream_http_x_username;
       #               proxy_set_header X-User $username;

       #               # Renew SSO cookie on request
       #               auth_request_set $cookie $upstream_http_set_cookie;
       #               add_header Set-Cookie $cookie;
       #             '';
       #         };

       #         locations."/sso-auth" = {
       #           proxyPass = "http://localhost:${toString cfg.sso.port}/auth";
       #           extraConfig = ''
       #             # Do not allow requests from outside
       #             internal;
#
       #             # Do not forward the request body
       #             proxy_pass_request_body off;
       #             proxy_set_header Content-Length "";
#
       #             # Set X-Application according to subdomain for matching
       #             proxy_set_header X-Application "${subdomain}";
#
       #             # Set origin URI for matching
       #             proxy_set_header X-Origin-URI $request_uri;
       #           '';
       #         };
       #       })
       #     ])
       #   );
    };

    networking.firewall.allowedTCPPorts = [ 80 443 ];

    # Nginx needs to be able to read the certificates
    users.users.nginx.extraGroups = [ "acme" ];

    security.acme = {
      defaults.email = "lily@buny.plus";

      acceptTerms = true;
      # Use DNS wildcard certificate
      certs =
        {
          "${domain}" = {
            extraDomainNames = [ "*.${domain}" ];
            dnsProvider = "gandiv5";
            inherit (cfg.acme) credentialsFile;
          };
        };
    };

    systemd.services."acme-${domain}" = {
      serviceConfig = {
        Environment = [
          # Since I do a "weird" setup with a wildcard CNAME
          "LEGO_DISABLE_CNAME_SUPPORT=true"
        ];
      };
    };

  };
}