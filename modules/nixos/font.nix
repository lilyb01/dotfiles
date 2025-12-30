{ inputs, pkgs, ... }: {
  config = {
    fonts = {
      packages = with pkgs; [
        # icon fonts
        material-design-icons
        corefonts
        ubuntu-classic
        powerline-fonts
        font-awesome
        source-code-pro
        noto-fonts
        #noto-fonts-cjk
        noto-fonts-color-emoji
        #emojione
        kanji-stroke-order-font
        ipafont
        liberation_ttf

        #(nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })

        # monospace
        cozette

        corefonts
        vista-fonts

        #inputs.apple-fonts.packages.${pkgs.system}.sf-pro
        #inputs.apple-fonts.packages.${pkgs.system}.sf-compact
        #inputs.apple-fonts.packages.${pkgs.system}.sf-mono
        #inputs.apple-fonts.packages.${pkgs.system}.sf-arabic
        #inputs.apple-fonts.packages.${pkgs.system}.ny

      ];

      # use fonts specified by user rather than default ones
      enableDefaultPackages = false;

      # user defined fonts
      # the reason there's Noto Color Emoji everywhere is to override DejaVu's
      # B&W emojis that would sometimes show instead of some Color emojis
      fontconfig.defaultFonts = {
        serif = ["Noto Serif" "Noto Color Emoji" "IPAPMincho"];
        sansSerif = ["Noto Sans" "Noto Color Emoji" "IPAPGothic"];
        monospace = ["Source Code Pro" "Noto Color Emoji" "IPAGothic"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
