{ lib
, config
, ...
}:
let
  inherit (lib) types mkIf mkOption mkBefore getExe;

  cfg = config.custom.terminal.foot;

  # move these to home.nix later... idgaf rn
  font = "Cozette";
  size = 9;
  opacity = 0.80;
in
{
  options.custom.terminal.foot = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable foot terminal";
    };
  };

  config = mkIf cfg.enable {

    programs.foot = {
        enable = true;
        settings = {
            main = let
                withSize = "size=${toString size}";
            in {
                font = "${font}:${withSize}";
                font-bold = "${font}:style=Bold:${withSize}";
                box-drawings-uses-font-glyphs = true;
            };

            scrollback = {
                lines = 10000;
            };

            url = {
                launch = "xdg-open \${url}";
                protocols = "http, https, ftp, ftps, file";
            };

            colors = {
                alpha = opacity;
                background = "000000";
            };
        };
    };

  };
}