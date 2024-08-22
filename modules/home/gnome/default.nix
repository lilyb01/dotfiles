{ lib
, config
, pkgs
, ...
}:
let
  inherit (builtins) map;
  inherit (lib) mkOption mkDefault;

  cfg = config.custom.gnome;
in
{
  imports = [
    ./extensions.nix
  ];

  options.custom.gnome = {
    extensions = mkOption {
      type = with lib.types; listOf package;
      description = "Gnome extension packages to install";
      default = with pkgs.gnomeExtensions; [
        appindicator
        dash-to-dock
        overview-background
        clipboard-indicator
        pip-on-top
      ];
    };

    themes = mkOption {
        type = with lib.types; listOf package;
        description = "Themes, icons, etc";
        default = with pkgs; [
            papirus-icon-theme
        ];
    };

    favorites = mkOption {
      type = with lib.types; listOf str;
      description = "Favorite apps. A list of .desktop files";
      default = [ ];
    };
  };

  config = {
    custom.gnome = {
      favorites = [
        "org.gnome.Nautilus.desktop"
      ];
    };

    home.packages = cfg.extensions ++ cfg.themes;

    dconf = {
      enable = true;
      settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          dissabled-extensions = [ ];
          enabled-extensions = map (pkg: pkg.extensionUuid) cfg.extensions;
          favorite-apps = cfg.favorites;
        };
        "org/gnome/mutter" = {
          edge-tiling = true;
          experimental-features = [ "scale-monitor-framebuffer" ];
        };
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          enable-hot-corners = true;
          show-battery-percentage = true;
          icon-theme = "Papirus-Dark";
        };
        "org/gnome/desktop/background" = {
            picture-uri = "file:///home/lily/wallpaper.jpg";
            picture-uri-dark = "file:///home/lily/wallpaper_dark.jpg";
        };
        "org/gnome/desktop/peripherals/mouse" = {
          accel-profile = "default";
          natural-scroll = false;
        };
        "org/gnome/desktop/peripherals/touchpad" = {
          send-events = "enabled";
          tap-to-click = true;
          two-finger-scrolling-enabled = true;
          edge-scrolling-enabled = false;
          natural-scroll = false;
        };
      };
    };
  };
}