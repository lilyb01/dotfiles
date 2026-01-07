{ pkgs, ... }: {
    config = {
        stylix = {
            enable = true;
            image = "${../../wallpaper/wallpaper.jpg}";
            polarity = "dark";

            base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

            fonts = {
                serif = {
                    package = pkgs.dejavu_fonts;
                    name = "DejaVu Serif";
                };
    
                sansSerif = {
                    package = pkgs.dejavu_fonts;
                    name = "DejaVu Sans";
                };
    
                monospace = {
                    name = "Source Code Pro";
                };
    
                emoji = {
                    package = pkgs.noto-fonts-color-emoji;
                    name = "Noto Color Emoji";
                };

                sizes = {
                    desktop = 9;
                    applications = 9;
                    terminal = 9;
                    popups = 9;
                };
            };
        };
    };
}
