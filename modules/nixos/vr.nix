{ pkgs, ... }: {
  # Core packages/apps for all systems
  # TODO add options to toggle some if needed
  config = {
    services.monado = {
        enable = true;
        defaultRuntime = true; # Register as default OpenXR runtime
    };
    systemd.user.services.monado.environment = {
        STEAMVR_LH_ENABLE = "1";
        XRT_COMPOSITOR_COMPUTE = "1";
        WMR_HANDTRACKING = "0";
    };
  };
}
