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
    gamescope.enable = true;
    steamdeck.enable = true;
    deckyloader.enable = true;
    boot.manager = "systemd-boot";
    tailscale.enable = true;
  };

  # You can import other NixOS modules here
  imports = with inputs.hardware.nixosModules; [
    common-cpu-amd
    common-cpu-amd-pstate
    common-cpu-amd-zenpower
    common-gpu-amd
    common-pc-ssd
    ./hardware-configuration.nix
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
