{ ... }: {
  config = {
    programs.hyfetch = {
        enable = true;
        settings = {
            "preset" = "nonbinary";
            "mode" = "rgb";
            "light_dark" = "dark";
            "lightness" = 0.65;
            "color_align" = {
                "mode" = "horizontal";
                "custom_colors" = [];
                "fore_back" = null;
            };
            "backend" = "fastfetch";
            "args" = null;
            "distro"= null;
            "pride_month_shown" = [];
            "pride_month_disable" = false;
        };
    };
  };
}