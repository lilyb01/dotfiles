# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  pkgs,
  ...
}: {

  custom = {
    boot.splash = true;
    desktop.gnome = false;
    desktop.kde = true;
    appimage.enable = false;
    flatpak.enable = false;
    gaming.enable = false;
    gamescope.enable = false;
    steamdeck.enable = false;
    boot.manager = "systemd-boot";
    tailscale.enable = true;
    login.manager = "none";
    server.samba.enable = true;
    server.samba.shares = {
      Sonata = {
        path = "/mnt/Sonata";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "veto files" = "/.apdisk/.DS_Store/.TemporaryItems/.Trashes/desktop.ini/ehthumbs.db/Network Trash Folder/Temporary Items/Thumbs.db/";
        "delete veto files" = "yes";
      };
    };
    virt.podman.enable = true;
    server.fail2ban.enable = true;
    server.nextcloud.enable = true;
    server.nextcloud.passwordFile = "/var/lib/nextcloud/password.txt";
    server.nginx.enable = true;
    server.nginx.acme.credentialsFile = "/var/lib/acme/creds.env";
    server.pms.enable = true;
    server.qBittorrent.enable = true;
    server.qBittorrent.openFirewall = true;
    server.sabnzbd.enable = true;
    server.servarr = {
      enable = true;
      bazarr.enable = false;
      prowlarr.enable = true;
      lidarr.enable = true;
      sonarr.enable = true;
      radarr.enable = true;
    };
  };

  # You can import other NixOS modules here
  imports = with inputs.hardware.nixosModules; [
    common-cpu-amd
    common-cpu-amd-pstate
    common-cpu-amd-zenpower
    common-gpu-amd
    common-pc-ssd
    ./hardware-configuration.nix
  ];

  boot.initrd.kernelModules = [ ];

  networking.domain = "tapioca.buny.plus";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
