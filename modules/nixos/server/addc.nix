# https://nixos.wiki/wiki/Samba#Active_Directory_Domain_Controller

# After evaluating, you should see that the Samba service crashed because we haven't setup the database yet.
# To do that, let's run the following command, updated with your own configuration:
# `samba-tool domain provision --server-role=dc --use-rfc2307 --dns-backend=SAMBA_INTERNAL --realm=SAMDOM.EXAMPLE.COM --domain=SAMDOM --adminpass=Passw0rd`
# Then restart the samba service with `sudo systemctl restart samba`, and you're ready to go! 

{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.services.samba;
  samba = cfg.package;
  nssModulesPath = config.system.nssModules.path;
  adDomain = "samdom.example.com";
  adWorkgroup = "SAM";
  adNetbiosName = "SAMDOM";
  staticIp = "10.42.129.160";
in {
  # Disable resolveconf, we're using Samba internal DNS backend
  systemd.services.resolvconf.enable = false;
  environment.etc = {
    resolvconf = {
      text = ''
        search ${adDomain}
        nameserver ${staticIp}
      '';
    };
  };

  # Rebuild Samba with LDAP, MDNS and Domain Controller support
  nixpkgs.overlays = [ (self: super: {
    samba = (super.samba.override {
      enableLDAP = true;
      enableMDNS = true;
      enableDomainController = true;
      enableProfiling = true; # Optional for logging
       # Set pythonpath manually (bellow with overrideAttrs) as it is not set on 22.11 due to bug
    }).overrideAttrs (finalAttrs: previousAttrs: {
        pythonPath = with super; [ python3Packages.dnspython python3Packages.markdown tdb ldb talloc ];
      });
  })];

  # Disable default Samba `smbd` service, we will be using the `samba` server binary
  systemd.services.samba-smbd.enable = false;  
  systemd.services.samba = {
    description = "Samba Service Daemon";

    requiredBy = [ "samba.target" ];
    partOf = [ "samba.target" ];

    serviceConfig = {
      ExecStart = "${samba}/sbin/samba --foreground --no-process-group";
      ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
      LimitNOFILE = 16384;
      PIDFile = "/run/samba.pid";
      Type = "notify";
      NotifyAccess = "all"; #may not do anything...
    };
    unitConfig.RequiresMountsFor = "/var/lib/samba";
  };
  services.samba = {
    enable = true;
    enableNmbd = false;
    enableWinbindd = false;
    configText = ''
      # Global parameters
      [global]
          dns forwarder = ${staticIp}
          netbios name = ${adNetbiosName}
          realm = ${toUpper adDomain}
          server role = active directory domain controller
          workgroup = ${adWorkgroup}
          idmap_ldb:use rfc2307 = yes

      [sysvol]
          path = /var/lib/samba/sysvol
          read only = No

      [netlogon]
          path = /var/lib/samba/sysvol/${adDomain}/scripts
          read only = No
    '';
  };  
}