{ pkgs, ... }: {
    config = {
        stylix = {
            enable = true;
            image = "${../../wallpaper/wallpaper.jpg}";
            polarity = "dark";

            base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

            cursor = {
                package = pkgs.apple-cursor;
                name = "macOS";
                size = 24;
            };

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

            icons = {
                enable = true;
                package = pkgs.catppuccin-papirus-folders.override {
                    flavor = "mocha";
                    accent = "pink";
                };
                dark = "Papirus-Dark";
                light = "Papirus-Light";
            };

            opacity = {
                terminal = 0.8;
            };     

            targets = {
                foot = {
                    #colors.override = ;
                    fonts.override = {
                        monospace.name = "Cozette";
                    };
                };
            };
        };
    };
}
