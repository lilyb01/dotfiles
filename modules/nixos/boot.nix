{ config
, lib
, ...
}:
let
  inherit (lib) mkOption;
  cfg = config.custom.boot;
in
{
  options.custom.boot = {
    manager = mkOption {
      description = "The boot manager to use";
      default = "systemd-boot";
      type = lib.types.enum [ "systemd-boot" "grub" ];
    };
  };

  config = {

      #boot.loader.systemd-boot = lib.mkIf (cfg.manager == "grub") {
      #  enable = false;
      #};

    boot.loader = {
      ${cfg.manager} = {
        enable = true;
        configurationLimit = 8;
    #    useOSProber = true;
    #    efiSupport = true;
    #    device = "nodev";
      };

      # Disable boot timeout.
      # Spam "almost any key" to show the menu (<space> work well).
      # Or run: systemctl reboot --boot-loader-menu=0
      timeout = 5;

      efi.canTouchEfiVariables = true;
    };
  };
}
