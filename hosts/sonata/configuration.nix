# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  ...
}: {

  custom = {
    boot.splash = true;
    desktop.gnome = false;
    desktop.kde = false;
    desktop.hyprland = true;
    flatpak.enable = true;
    gaming.enable = true;
    uxplay.enable = true;
    #gamescope.enable = false;
    #steamdeck.enable = false;
    boot.manager = "systemd-boot";
    tailscale.enable = true;
    login.manager = "dms-greeter";
    virt.podman.enable = true;
    virt.waydroid.enable = true;
    # server.samba.enable = true;
    #server.samba.shares = {
    #  Home = {
    #    path = "/home/lily";
    #    browseable = "yes";
    #    "read only" = "no";
    #    "guest ok" = "no";
    #    "veto files" = "/.apdisk/.DS_Store/.TemporaryItems/.Trashes/desktop.ini/ehthumbs.db/Network Trash Folder/Temporary Items/Thumbs.db/";
    #    "delete veto files" = "yes";
    #  };
    #};
  };

  disabledModules = [ "../../modules/nixos/gamescope.nix" ];

  # You can import other NixOS modules here
  imports = with inputs.hardware.nixosModules; [
    framework-16-amd-ai-300-series-nvidia
    ./hardware-configuration.nix
  ];

  hardware.nvidia.prime = {
    amdgpuBusId = "PCI:195:0:0";
    nvidiaBusId = "PCI:194:0:0";
  };

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  networking.networkmanager.enable = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  boot.initrd.kernelModules = [ "amdgpu" ];

  home-manager.backupFileExtension = "backup";

  networking.firewall = {
    allowedTCPPorts = [ 42000 42001 22000 ];
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
