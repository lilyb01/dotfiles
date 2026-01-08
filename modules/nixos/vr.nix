{
  lib,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    (final: prev: {
      monado = prev.monado.overrideAttrs (prevAttrs: rec {
        #src = inputs.monado;

        patches = [
          ./patches/monado-shutdown-ipc-server-on-SIGTERM.diff
          ./patches/monado-beat-saber-blend.patch
          # ./patches/monado-bsb-survive.patch
        ];
      });
    })
  ];

  boot.kernelPatches = [
    {
      name = "drm/edid: parse DRM VESA dsc bpp target";
      patch = ./patches/0001-drm-edid-parse-DRM-VESA-dsc-bpp-target.patch;
    }
    {
      name = "drm/amd: use fixed dsc bits-per-pixel from edid";
      patch = ./patches/0002-drm-amd-use-fixed-dsc-bits-per-pixel-from-edid.patch;
    }
  ];
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="35bd", TAG+="uaccess", MODE="0660", GROUP="wheel"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="35bd", TAG+="uaccess", MODE="0660", GROUP="wheel"
  '';


  services.monado = {
    enable = true;
    highPriority = true;

    package = pkgs.monado.overrideAttrs (prevAttrs: {
      cmakeFlags =
        prevAttrs.cmakeFlags
        ++ [
          (lib.cmakeBool "XRT_HAVE_OPENCV" false)
        ];
    });

    defaultRuntime = true;
    # WARNING: This deletes stuff in the users home
    forceDefaultRuntime = false;
  };

  systemd.user.services.monado.environment = {
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";

    # VIVE_LOG = "debug";
    # XRT_COMPOSITOR_LOG = "debug";
    # XRT_LOG = "debug";
  };
}
