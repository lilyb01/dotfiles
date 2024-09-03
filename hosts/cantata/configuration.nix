# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  ...
}: {

  custom = {
    boot.splash = true;
    desktop.gnome = true;
    desktop.kde = true;
    flatpak.enable = true;
    gaming.enable = true;
    gamescope.enable = false;
    steamdeck.enable = false;
    boot.manager = "systemd-boot";
    tailscale.enable = true;
    login.manager = "sddm";
    virt.waydroid.enable = true;
    server.samba.enable = true;
    server.samba.shares = {
      Home = {
        path = "/home/lily";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "veto files" = "/.apdisk/.DS_Store/.TemporaryItems/.Trashes/desktop.ini/ehthumbs.db/Network Trash Folder/Temporary Items/Thumbs.db/";
        "delete veto files" = "yes";
      };
    };
  };

  disabledModules = [ "../../modules/nixos/gamescope.nix" ];

  # You can import other NixOS modules here
  imports = with inputs.hardware.nixosModules; [
    common-cpu-amd
    common-cpu-amd-pstate
    common-cpu-amd-zenpower
    common-gpu-amd
    common-pc-ssd
    ./hardware-configuration.nix
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
