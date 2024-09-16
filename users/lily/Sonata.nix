{ lib, pkgs, inputs, ... }: {
    custom = {
        editors.vscode = true;
        internet.extras = with pkgs; [
          ungoogled-chromium
          weechat
          vesktop
          telegram-desktop
          anydesk
          bitwarden-desktop
          nicotine-plus
          warpinator
          tigervnc
        ];
    };

    home.stateVersion = "24.05";
}