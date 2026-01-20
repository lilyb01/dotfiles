{ config, lib, pkgs, ... }:
let
  cfg = config.custom.gaming;
  
in
{
  options.custom.gaming.enable = lib.mkEnableOption "gaming";

  config = lib.mkIf cfg.enable {
    hardware.graphics.enable = true;

    programs.steam = let
      patchedBwrap = pkgs.bubblewrap.overrideAttrs (o: {
        patches = (o.patches or []) ++ [
          ./vr/patching/bwrap.patch
        ];
      });
    in {
      enable = true;
      package = pkgs.steam.override {
        buildFHSEnv = (args: ((pkgs.buildFHSEnv.override {
          bubblewrap = patchedBwrap;
        }) (args // {
          extraBwrapArgs = (args.extraBwrapArgs or []) ++ [ "--cap-add ALL" ];
        })));

        extraProfile = ''
          # fixes timezones on vrchat
          unset TZ
          # allows monado to be used
          export PRESSURE_VESSEL_FILESYSTEMS_RW=$XDG_RUNTIME_DIR/monado_comp_ipc
        '';
      };

      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        protontricks
      ];
    };


    #programs.steam = {
    #  enable = true;
    #  package = pkgs.steam.override {
    #    # force proton to use wayland
    #    #export PROTON_ENABLE_WAYLAND=1
    #    # FIXME: This allowes xrizer & opencomposite to work without something in home
    #    #export XR_RUNTIME_JSON=${config.services.monado.package}/share/openxr/1/openxr_monado.json
    #    extraProfile = ''
    #      # fixes timezones on vrchat
    #      unset TZ
    #      # allows monado to be used
    #      export PRESSURE_VESSEL_FILESYSTEMS_RW=$XDG_RUNTIME_DIR/monado_comp_ipc
    #    '';
    #  };
    #
    #  remotePlay.openFirewall = true;
    #  localNetworkGameTransfers.openFirewall = true;
    #  extraCompatPackages = with pkgs; [
    #    proton-ge-bin
    #    protontricks
    #  ];
    #};

#    programs.nix-ld = {
#      enable = true;
#      libraries = pkgs.steam-run.fhsenv.args.multiPkgs pkgs;
#    };

    environment.systemPackages = with pkgs; [
      xivlauncher
      prismlauncher
      steam-run
      r2modman
      alcom
    ];

    nixpkgs.config.allowUnfreePredicate = pkg: lib.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-run"
    ];
  };
}
