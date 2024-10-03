{ lib, pkgs, inputs, ... }: {
    custom = {
        editors.vscode = true;
        gnome.favorites =  [
           "firefox-devedition.desktop"
           "org.gnome.Nautilus.desktop"
           "org.gnome.Geary.desktop"
           "org.gnome.Calendar.desktop"
           "com.plexamp.Plexamp.desktop"
           "obsidian.desktop"
           "code.desktop"
           "org.codeberg.dnkl.foot.desktop"
           "vesktop.desktop"
           "org.telegram.desktop.desktop" 
        ];
        gnome.extensions = with pkgs.gnomeExtensions; [
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
        internet.extras = with pkgs; [
          ungoogled-chromium
          weechat
          vesktop
          telegram-desktop
          anydesk
          bitwarden-desktop
          nicotine-plus
          warpinator
          tigervnc
        ];
        #vr.home = true;
    };

      home.file."wallpaper.jpg" = {
        source = ../../wallpaper/wallpaper.jpg;
      };
      home.file."wallpaper_dark.jpg" = {
        source = ../../wallpaper/wallpaper_dark.jpg;
      };
      home.file."lockscreen.jpg" = {
        source = ../../wallpaper/lockscreen.jpg;
      };
      home.file."lockscreen-dark.jpg" = {
        source = ../../wallpaper/lockscreen-dark.jpg;
      }; 

    home.stateVersion = "24.05";
}