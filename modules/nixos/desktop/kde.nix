{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  enabled = config.custom.desktop.kde;
in
{
  options.custom.desktop.kde = mkEnableOption "KDE Plasma 6 desktop";

  config = mkIf enabled {
      # Enable the X11 windowing system.
      # You can disable this if you're only using the Wayland session.
      services.xserver.enable = true;

      # Enable the KDE Plasma Desktop Environment.
      services.desktopManager.plasma6 = {
          enable = true;
      };

      # workaround for if gnome is also installed
      programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";

      environment.systemPackages = with pkgs; [
          libsForQt5.discover
          kdePackages.kate
          gparted
      ];

      # Configure keymap in X11
      services.xserver = {
          layout = "us";
          xkbVariant = "";
      };

      services.gvfs.enable = true;
  };
}