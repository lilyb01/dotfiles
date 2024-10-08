# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  ...
}: {

    virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 2048; # Use 2048MiB memory.
      cores = 3;
      graphics = true;
    };
  };

  custom = {
    boot.splash = true;
    desktop.gnome = true;
    flatpak.enable = true;
    gaming.enable = true;
    gamescope.enable = true;
    boot.manager = "grub";
  };

  # You can import other NixOS modules here
  imports = with inputs.hardware.nixosModules; [
    common-cpu-amd
    common-cpu-amd-pstate
    common-cpu-amd-zenpower
    common-gpu-amd
    common-pc-ssd
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
