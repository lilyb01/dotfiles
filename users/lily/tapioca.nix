{ lib, pkgs, inputs, ... }: {
    custom = {
      editors.vscode = true;
      internet.extras = with pkgs; [
        anydesk
      ];
      media.enable = false;
      obsidian.enable = false;
    };

      home.file."wallpaper.jpg" = {
        source = ../../wallpaper/wallpaper.jpg;
      };
      home.file."wallpaper_dark.jpg" = {
        source = ../../wallpaper/wallpaper_dark.jpg;
      };
      home.file."lockscreen.jpg" = {
        source = ../../wallpaper/lockscreen.jpg;
      };
      home.file."lockscreen-dark.jpg" = {
        source = ../../wallpaper/lockscreen-dark.jpg;
      }; 

    home.stateVersion = "24.05";
}