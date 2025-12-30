{ config
, lib
, ...
}:
let
  inherit (lib) types mkOption mkIf;
  cfg = config.custom.login;
in
{
  options.custom.login = {
    manager = mkOption {
      type = types.enum [ "none" "gdm" "sddm" "lightdm" "dms-greeter" ];
      default = "gdm";
    };
  };
  config = {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm = mkIf (cfg.manager == "gdm") {
      enable = true;
      wayland = true;
    };
    services.xserver.displayManager.lightdm = {
      enable = mkIf (cfg.manager == "sddm") true; # sorry if this is confusing LMAO im lazy
      greeters.slick = {
        enable = true;
        draw-user-backgrounds = false;
        extraConfig = ''
          draw-grid=true
          show-clock=true
          logo=${../../../wallpaper/logo.png}
        '';
      };
      background = "${../../../wallpaper/login.jpg}";
    };

    services.displayManager.dms-greeter = {
        enable = mkIf (cfg.manager == "dms-greeter") true;
        configHome = "/home/lily";
        compositor.name = "hyprland";
    };

  };
}
