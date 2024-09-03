{...}: {
  imports = [
    ./fail2ban.nix
    ./gitea.nix
    ./nextcloud.nix
    ./nfs.nix
    ./nginx.nix
    ./plex.nix
    ./qbittorrent.nix
    ./samba.nix
    ./sabnzbd.nix
    ./servarr.nix
  ];
}