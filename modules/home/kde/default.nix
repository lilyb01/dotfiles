{ pkgs
, ... }:
{
  home.packages = with pkgs; [
    #libsForQt5.qtstyleplugin-kvantum
    #tela-circle-icon-theme
    #papirus-icon-theme
    #materia-kde-theme
    #capitaine-cursors
    #graphite-kde-theme
    #qogir-kde
  ];

  programs.plasma = {
    enable = true;
    overrideConfig = true; 

    #
    # Some high-level settings:
    #
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      theme = "Orchis-dark";
      colorScheme = "OrchisDark";
      cursor = {
        theme = "Adwaita";
        size = 24;
      };
      iconTheme = "Papirus-Dark";
      wallpaper = "${../../../wallpaper/wallpaper.jpg}";
     #windowDecorations = {
     #   theme = "";
     # };
    };

    hotkeys.commands."launch-konsole" = {
      name = "Launch Konsole";
      key = "Meta+Alt+K";
      command = "konsole";
    };

    fonts = {
      general = {
        family = "SF Pro Display";
        pointSize = 10;
      };
      menu = {
        family = "SF Pro Display";
        pointSize = 10;
      };
      toolbar = {
        family = "SF Pro Display";
        pointSize = 10;
      };
      windowTitle = {
        family = "SF Pro Display";
        pointSize = 10;
      };
      small = {
        family = "SF Compact Display";
        pointSize = 8;
      };
    };

    desktop = {
      icons = {
        arrangement = "topToBottom";
        alignment = "right";
        size = 2;
      };
    };

    panels = [
      # Windows-like panel at the bottom
      {
        location = "bottom";
        height = 46;
        screen = "all";
        widgets = [
          #{
          #  panelSpacer = {
          #    length = 2;
          #    settings.General.expanding = false;
          #  };
          #}
          # We can configure the widgets by adding the name and config
          # attributes. For example to add the the kickoff widget and set the
          # icon to "nix-snowflake" use the below configuration. This will
          # add the "icon" key to the "General" group for the widget in
          # ~/.config/plasma-org.kde.plasma.desktop-appletsrc.
          #{
          #  name = "org.kde.plasma.kickoff";
          #  config = {
          #    General = {
          #      icon = "nix-snowflake";
          #      alphaSort = true;
          #    };
          #  };
          #}
          # Or you can configure the widgets by adding the widget-specific options for it.
          # See modules/widgets for supported widgets and options for these widgets.
          # For example:
          {
            kickoff = {
              sortAlphabetically = true;
              icon = "nix-snowflake";
            };
          }
          # TODO manage in config
          {
            iconTasks = {
              launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:org.kde.konsole.desktop"
                "applications:firefox-devedition.desktop"
                "applications:plexamp.desktop"
                "applications:obsidian.desktop"
                "applications:code.desktop"
                "applications:Clip Studio Paint--CLIP Studio Paint--1725200014.930108.desktop"
                "applications:Toon Boom Harmony--Toon Boom Harmony 20--1726138940.343277.desktop"
                "applications:vesktop.desktop"
                "applications:org.telegram.desktop.desktop"
              ];
            };
          }
          # If no configuration is needed, specifying only the name of the
          # widget will add them with the default configuration.
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.showdesktop"
        ];
        #hiding = "autohide";
      }
      # Application name, Global menu and Song information and playback controls at the top
      {
        location = "top";
        screen = "all";
        height = 26;
        widgets = [
          {
            panelSpacer = {
              length = 2;
              settings.General.expanding = false;
            };
          }
          {
            kickoff = {
              sortAlphabetically = true;
              icon = "nix-snowflake";
            };
          }
          {
            applicationTitleBar = {
              behavior = {
                activeTaskSource = "activeTask";
              };
              layout = {
                elements = [ "windowTitle" ];
                horizontalAlignment = "left";
                showDisabledElements = "deactivated";
                verticalAlignment = "center";
              };
              overrideForMaximized = {
                enable = false;
                elements = [
                  "windowCloseButton"
                  "windowMinimizeButton"
                  "windowMaximizeButton"
                  "windowTitle"
                ];
              };
              titleReplacements = [
                {
                  type = "regexp";
                  originalTitle = "^Brave Web Browser$";
                  newTitle = "Brave";
                }
                {
                  type = "regexp";
                  originalTitle = ''\\bDolphin\\b'';
                  newTitle = "File Manager";
                }
              ];
              windowTitle = {
                font = {
                  bold = true;
                  fit = "fixedSize";
                  size = 10;
                };
                hideEmptyTitle = true;
                margins = {
                  bottom = 0;
                  left = 10;
                  right = 5;
                  top = 0;
                };
                source = "appName";
                undefinedWindowTitle = "Desktop";
              };
            };
          }
          "org.kde.plasma.appmenu"
          "org.kde.plasma.panelspacer"
          {
            systemTray.items = {
              # We explicitly show bluetooth and battery
              shown = [
                "org.kde.plasma.battery"
                "org.kde.plasma.bluetooth"
              ];
              # And explicitly hide networkmanagement and volume
              hidden = [
              ];
            };
          }
          {
            panelSpacer = {
              length = 4;
              settings.General.expanding = false;
            };
          }
          {
            digitalClock = {
              calendar.firstDayOfWeek = "sunday";
              time.format = "12h";
              font = {
                family = "SF Pro Display";
                size = 10;
                weight = 600;
              };
              settings = {
                Appearance = {
                  showDate = false;
                };
              };
            };
          }
          {
            panelSpacer = {
              length = 4;
              settings.General.expanding = false;
            };
          }
          "org.kde.milou"
        ];
      }
    ];

    #window-rules = [
    #  {
    #    description = "Dolphin";
    #    match = {
    #      window-class = {
    #        value = "dolphin";
    #        type = "substring";
    #     window-types = [ "normal" ];
    #    };
    #    apply = {
    #      noborder = {
    #        value = true;
    #        apply = "force";
    #      };
    #      # `apply` defaults to "apply-initially"
    #      maximizehoriz = true;
    #      maximizevert = true;
    #    };
    #  }
    #];

    powerdevil = {
      AC = {
        powerButtonAction = "lockScreen";
        autoSuspend = {
          action = "shutDown";
          idleTimeout = 1000;
        };
        turnOffDisplay = {
          idleTimeout = 1000;
          idleTimeoutWhenLocked = "immediately";
        };
      };
      battery = {
        powerButtonAction = "sleep";
        whenSleepingEnter = "standbyThenHibernate";
      };
      lowBattery = {
        whenLaptopLidClosed = "hibernate";
      };
    };

    kwin = {
      edgeBarrier = 0; # Disables the edge-barriers introduced in plasma 6.1
      cornerBarrier = false;
      effects = {
        minimization.animation = "magiclamp";
        wobblyWindows.enable = true;
      };
    #  scripts.polonium.enable = true;
    };

    kscreenlocker = {
      lockOnResume = true;
      timeout = 10;
    };

    #
    # Some mid-level settings:
    #
    shortcuts = {
      ksmserver = {
        "Lock Session" = [ "Screensaver" "Meta+Ctrl+Alt+L" ];
      };

      kwin = {
        "Expose" = "Meta+Space";
        "Switch Window Down" = "Meta+J";
        "Switch Window Left" = "Meta+H";
        "Switch Window Right" = "Meta+L";
        "Switch Window Up" = "Meta+K";
      };
    };


    #
    # Some low-level settings:
    #
    configFile = {
      baloofilerc."Basic Settings"."Indexing-Enabled" = false;
      kwinrc."org.kde.kdecoration2".ButtonsOnLeft = "SF";
      kwinrc.Plugins.screenedgeEnabled = false;
      dolphinrc.DetailsMode.PreviewSize = 16;
      kscreenlockerrc = {
        Greeter.WallpaperPlugin = "org.kde.potd";
        # To use nested groups use / as a separator. In the below example,
        # Provider will be added to [Greeter][Wallpaper][org.kde.potd][General].
        "Greeter/Wallpaper/org.kde.potd/General".Provider = "bing";
      };
    };
  };
}
