{ lib, ... }: {
    custom = {
        editors.vscode = true;
        gnome.favorites = lib.mkAfter [];
        gnome.extensions = [
          user-themes
          dash-to-dock
          window-title-is-back
          wiggle
          weather-or-not
          # transparent-window-moving
          tailscale-qs
          blur-my-shell
          compiz-windows-effect
          compiz-alike-magic-lamp-effect
          unlock-dialog-background
          logo-menu
          no-overview
          overview-background
          appindicator
          just-perfection
          notification-banner-reloaded
          status-area-horizontal-spacing
        ];
    };

    home.stateVersion = "24.05";
}