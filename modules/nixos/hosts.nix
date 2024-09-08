{ ... }: {
  config = {

    networking.hosts = {
      "10.4.21.91" = [
        "tapioca.buny.plus"
        "torrent.tapioca.buny.plus"
        "sabnzbd.tapioca.buny.plus"
        "plex.tapioca.buny.plus"
        "nextcloud.tapioca.buny.plus"
        "git.tapioca.buny.plus"
        "overseerr.tapioca.buny.plus"
        "sonarr.tapioca.buny.plus"
        "radarr.tapioca.buny.plus"
        "lidarr.tapioca.buny.plus"
        "prowlarr.tapioca.buny.plus"
      ];
    };

  };
}