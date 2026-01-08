{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  steam = "${config.xdg.dataHome}/Steam";

  # Default VR runtime for others to extend
  vr-default = {
    version = 1;
    jsonid = "vrpathreg";

    # May need the following due to my headset:
    # "${steam}/steamapps/common/Bigscreen Beyond Driver"
    external_drivers = null;
    config = [
      "${steam}/config"
    ];

    log = [
      "${steam}/logs"
    ];
  };
in {
  nixpkgs.overlays = [
    (final: prev: {
      xrizer-fbt = prev.xrizer.overrideAttrs (prevAttrs: {
        src = inputs.xrizer;

        cargoDeps = pkgs.rustPlatform.importCargoLock {
          lockFile = inputs.xrizer + "/Cargo.lock";
          outputHashes = {
            "openxr-0.19.0" = "sha256-mljVBbQTq/k7zd/WcE1Sd3gibaJiZ+t7td964clWHd8=";
          };
        };

        # NOTE: This comes from nixpkgs-xr, but isn't being applied for some reason
        patches =
          builtins.filter (
            patch: (!builtins.elem patch.name ["xrizer-fix-flaky-tests.patch"])
          )
          prevAttrs.patches;
      });
    })
  ];

  # xrizer by default
  xdg.configFile = {
    # Monado
    "openxr/1/active_runtime.json".source = lib.mkDefault (config.lib.file.mkOutOfStoreSymlink "/etc/xdg/openxr/1/active_runtime.json");

    "openvr/openvrpaths.vrpath".text = lib.mkDefault (builtins.toJSON (
      vr-default
      // {
        "runtime" = [
          "${pkgs.xrizer-fbt}/lib/xrizer"
        ];
      }
    ));
  };

  # Other configs (for easy access)
  specialisation = {
    vr-opencomosite.configuration = {
      xdg.configFile = {
        # Monado
        "openxr/1/active_runtime.json".source = config.lib.file.mkOutOfStoreSymlink "/etc/xdg/openxr/1/active_runtime.json";

        "openvr/openvrpaths.vrpath".text = builtins.toJSON (
          vr-default
          // {
            "runtime" = [
              "${pkgs.opencomposite}/lib/opencomposite"
            ];
          }
        );
      };
    };
    vr-steam.configuration = {
      xdg.configFile = {
        "openxr/1/active_runtime.json".source = config.lib.file.mkOutOfStoreSymlink "${steam}/steamapps/common/SteamVR/steamxr_linux64.json";

        "openvr/openvrpaths.vrpath".text = builtins.toJSON (
          vr-default
          // {
            "runtime" = [
              "${steam}/steamapps/common/SteamVR"
            ];
          }
        );
      };
    };
  };
}
