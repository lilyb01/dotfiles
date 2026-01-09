{
  lib,
  pkgs,
  inputs,
  ...
}: {
  #nixpkgs.overlays = [
  #  (final: prev: {
  #    monado = prev.monado.overrideAttrs (prevAttrs: rec {
  #      #src = inputs.monado;
#
  #      patches = [
  #        ../../patches/monado-shutdown-ipc-server-on-SIGTERM.diff
  #        ../../patches/monado-beat-saber-blend.patch
  #        # ./patches/monado-bsb-survive.patch
  #      ];
  #    });
  #  })
  #  (final: prev: {
  #    libsurvive = prev.libsurvive.overrideAttrs (prevAttrs: rec {
  #      version = "32cf62c52744fdc32003ef8169e8b81f6f31526b";
#
  #      patches =
  #        (prevAttrs.patches or [])
  #        ++ [
  #          ../../patches/survive-bsb.patch
  #        ];
#
  #      src = pkgs.fetchFromGitHub {
  #        owner = "cntools";
  #        repo = "libsurvive";
  #        rev = version;
  #        fetchSubmodules = true;
  #        hash = "sha256-PIQW5L0vtaYD2b8wuDAthWS+mDX4cvFELDSUZ7RD4Ac=";
  #      };
#
  #      buildInputs =
  #        prevAttrs.buildInputs
  #        ++ (with pkgs; [
  #          python3
  #        ]);
#
  #      postPatch = ''
  #        substituteInPlace survive.pc.in \
  #          libs/cnkalman/cnkalman.pc.in libs/cnmatrix/cnmatrix.pc.in \
  #          --replace '$'{exec_prefix}/@CMAKE_INSTALL_LIBDIR@ @CMAKE_INSTALL_FULL_LIBDIR@
  #      '';
  #    });
  #  })
#
  #];

  boot.kernelPatches = [
    #{
    #  name = "drm/edid: parse DRM VESA dsc bpp target";
    #  patch = "${../../patches/0001-drm-edid-parse-DRM-VESA-dsc-bpp-target.patch}";
    #}
    #{
    #  name = "drm/amd: use fixed dsc bits-per-pixel from edid";
    #  patch = "${../../patches/0002-drm-amd-use-fixed-dsc-bits-per-pixel-from-edid.patch}";
    #}
    {
      name = "allow any ctx priority on amdgpu";
      # See https://github.com/Frogging-Family/community-patches/blob/a6a468420c0df18d51342ac6864ecd3f99f7011e/linux61-tkg/cap_sys_nice_begone.mypatch
      patch = "${../../patches/cap_sys_nice_begone.patch}";
    }
    {
      name = "bsb support";
      patch = "${../../patches/bigscreen-beyond-kernel.patch}";
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
