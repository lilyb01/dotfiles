{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {

    "org/gnome/shell" = {
        disable-user-extensions = false;
    };

    "org/gnome/shell/extensions/Logo-menu" = {
      hide-icon-shadow = false;
      menu-button-extensions-app = "com.mattjakeman.ExtensionManager.desktop";
      menu-button-icon-image = 23;
      menu-button-icon-size = 17;
      show-activities-button = true;
      show-lockscreen = true;
      show-power-options = true;
      symbolic-icon = true;
      use-custom-icon = false;
    };

    "org/gnome/shell/extensions/appindicator" = {
      icon-contrast = 0.0;
      icon-opacity = 255;
      icon-saturation = 0.9999999999999999;
      icon-size = 0;
      legacy-tray-enabled = true;
      tray-pos = "right";
    };

    "org/gnome/shell/extensions/blur-my-shell" = {
      settings-version = 2;
    };

    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      brightness = 0.6;
      override-background = true;
      pipeline = "pipeline_default";
      sigma = 30;
      static-blur = true;
      style-dash-to-dock = 0;
      unblur-in-overview = true;
    };

    "org/gnome/shell/extensions/blur-my-shell/lockscreen" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      pipeline = "pipeline_default";
      style-components = 2;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      brightness = 0.5;
      force-light-text = false;
      override-background-dynamically = true;
      pipeline = "pipeline_default";
      sigma = 32;
      static-blur = true;
      style-panel = 0;
    };

    "org/gnome/shell/extensions/blur-my-shell/screenshot" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/window-list" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/com/github/hermes83/compiz-windows-effect" = {
      friction = 3.5;
      mass = 70.0;
      maximize-effect = false;
      resize-effect = false;
      speedup-factor-divider = 12.0;
      spring-k = 3.8;
      x-tiles = 6.0;
      y-tiles = 6.0;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      always-center-icons = false;
      animate-show-apps = true;
      apply-custom-theme = true;
      apply-glossy-effect = false;
      background-opacity = 1.0;
      custom-theme-customize-running-dots = false;
      custom-theme-shrink = false;
      dash-max-icon-size = 48;
      dock-position = "LEFT";
      extend-height = true;
      height-fraction = 0.9;
      icon-size-fixed = false;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      isolate-monitors = false;
      isolate-workspaces = false;
      max-alpha = 0.8;
      multi-monitor = false;
      preferred-monitor = -2;
      preferred-monitor-by-connector = "DP-1";
      preview-size-scale = 0.0;
      running-indicator-dominant-color = false;
      running-indicator-style = "DOTS";
      show-apps-at-top = false;
      show-mounts = false;
      show-trash = false;
      show-windows-preview = true;
      transparency-mode = "FIXED";
      unity-backlit-items = false;
    };

    "org/gnome/shell/extensions/just-perfection" = {
      accessibility-menu = true;
      activities-button = true;
      animation = 5;
      background-menu = true;
      clock-menu = true;
      clock-menu-position = 1;
      clock-menu-position-offset = 6;
      controls-manager-spacing-size = 0;
      dash = true;
      dash-app-running = true;
      dash-icon-size = 0;
      dash-separator = true;
      double-super-to-appgrid = true;
      keyboard-layout = true;
      max-displayed-search-results = 0;
      notification-banner-position = 1;
      osd = true;
      panel = true;
      panel-in-overview = true;
      panel-notification-icon = true;
      panel-size = 0;
      power-icon = true;
      quick-settings = true;
      ripple-box = false;
      search = true;
      show-apps-button = true;
      startup-status = 1;
      theme = false;
      window-demands-attention-focus = false;
      window-picker-icon = true;
      window-preview-caption = true;
      window-preview-close-button = true;
      workspace = true;
      workspace-background-corner-size = 0;
      workspace-peek = false;
      workspace-popup = true;
      workspace-wrap-around = false;
      workspaces-in-app-grid = true;
    };

    "org/gnome/shell/extensions/notification-banner-reloaded" = {
      anchor-horizontal = 1;
      animation-direction = 1;
      animation-time = 500;
      padding-vertical = 12;
    };

    "org/gnome/shell/extensions/status-area-horizontal-spacing" = {
      hpadding = 6;
    };

    "org/gnome/shell/extensions/system-monitor" = {
      show-swap = false;
    };

    "org/gnome/shell/extensions/transparent-window-moving" = {
      window-opacity = 203;
    };

    "org/gnome/shell/extensions/unlock-dialog-background" = {
      picture-uri = "/home/lily/lockscreen.jpg";
      picture-uri-dark = "/home/lily/lockscreen-dark.jpg";
    };

    "org/gnome/shell/extensions/weatherornot" = {
      position = "right";
    };

    "org/gnome/shell/extensions/wiggle" = {
      cursor-size = 96;
    };
  };
}