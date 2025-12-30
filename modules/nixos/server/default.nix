{...}: {
  imports = [
    # TODO ersatztv
    ./fail2ban.nix
    ./gitea.nix
    ./jellyseerr.nix
    ./nextcloud.nix
    ./nfs.nix
    ./nginx.nix
    ./plex.nix
    ./qbittorrent.nix
    ./resilio.nix
    #./samba.nix
    ./sabnzbd.nix
    ./servarr.nix
  ];
}
