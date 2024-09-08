# A self-hosted cloud.
{ config, lib, pkgs, ... }:
let
  cfg = config.custom.server.nextcloud;
in
{
  options.custom.server.nextcloud = with lib; {
    enable = mkEnableOption "Nextcloud";
    maxSize = mkOption {
      type = types.str;
      default = "20G";
      example = "1G";
      description = "Maximum file upload size";
    };
    admin = mkOption {
      type = types.str;
      default = "Lily";
      example = "admin";
      description = "Name of the admin user";
    };
    passwordFile = mkOption {
      type = types.str;
      example = "/etc/nextcloud-admin-pass";
      description = ''
        Path to a file containing the admin's password, must be readable by
        'nextcloud' user.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    environment.etc."nextcloud-admin-pass".text = "changemechangeme";
    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud29;
      hostName = "nextcloud.${config.networking.domain}";
      home = "/var/lib/nextcloud";
      maxUploadSize = cfg.maxSize;
      configureRedis = true;
      config = {
        adminuser = cfg.admin;
        adminpassFile = cfg.passwordFile;
      #  dbtype = "pgsql";
      #  dbhost = "/run/postgresql";
      };

      https = true;

      settings = {
        overwriteprotocol = "https"; # Nginx only allows SSL
      };

      extraApps = {
        inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
      };
      extraAppsEnable = true;

      notify_push = {
        enable = true;
        # Allow using the push service without hard-coding my IP in the configuration
        bendDomainToLocalhost = true;
      };
    };

#    services.postgresql = {
#      enable = true;
#      ensureDatabases = [ "nextcloud" ];
#      ensureUsers = [
#        {
#          name = "nextcloud";
#          ensureDBOwnership = true;
#        }
#      ];
#    };

    services.nginx.virtualHosts."nextcloud.${config.networking.domain}" = {
      forceSSL = true;
      useACMEHost = config.networking.domain;
    };

    #my.services.backup = {
    #  paths = [
    #    config.services.nextcloud.home
    #  ];
    #  exclude = [
    #    # image previews can take up a lot of space
    #    "${config.services.nextcloud.home}/data/appdata_*/preview"
    #  ];
    #};
  };
}