{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib) mapAttrsToList mkIf mkOption types;
  cfg = config.custom.media;
in
{
  options.custom.media = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Media Applications";
    };
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
        # Video/Audio data composition framework tools like "gst-inspect", "gst-launch" ...
        gst_all_1.gstreamer
        # Common plugins like "filesrc" to combine within e.g. gst-launch
        gst_all_1.gst-plugins-base
        # Specialized plugins separated by quality
        gst_all_1.gst-plugins-good
        gst_all_1.gst-plugins-bad
        gst_all_1.gst-plugins-ugly
        # Plugins to reuse ffmpeg to play almost every video format
        gst_all_1.gst-libav
        # Support the Video Audio (Hardware) Acceleration API
        gst_all_1.gst-vaapi

        # audio control
        pavucontrol
        playerctl
        pulsemixer
        # images
        imv

        audacity
        easyeffects
        krita

        mpv
        plex-desktop
        plexamp

        yt-dlp
        ffmpeg
    ];

    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-tuna
        #obs-webkitgtk
        obs-vkcapture
        obs-gstreamer
        obs-text-pthread
        obs-composite-blur
        obs-pipewire-audio-capture
      ];
    };

    services = {
        playerctld.enable = true;
    };
  };
}
