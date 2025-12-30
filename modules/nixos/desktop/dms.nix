{ pkgs
, ... }:
{
    programs.dms-shell = {
        enable = true;
        enableAudioWavelength = true;
        enableCalendarEvents = true;
        enableClipboard = true;
        enableDynamicTheming = true;
        enableSystemMonitoring = true;
        enableVPN = true;
        systemd = {
            enable = true;
            restartIfChanged = true;
        };
    };
}
