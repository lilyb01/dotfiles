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
      type = types.enum [ "none" "gdm" "sddm" "lightdm" ];
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

  };
}
