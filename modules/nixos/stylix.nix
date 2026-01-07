{ pkgs, ... }: {
    config = {
        stylix = {
            enable = true;
            image = /home/lily/wallpaper.png;
            polarity = "dark";

            stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

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
                    name = "Cozette";
                };
    
                emoji = {
                    package = pkgs.noto-fonts-color-emoji;
                    name = "Noto Color Emoji";
                };
            };
        };
    };
}