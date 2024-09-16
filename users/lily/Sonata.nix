{ lib, pkgs, inputs, ... }: {
    custom = {
        editors.vscode = false;
        media.enable = false;
        wine.enable = false;
        internet.enable = false;
    };

    home.stateVersion = "24.05";
}