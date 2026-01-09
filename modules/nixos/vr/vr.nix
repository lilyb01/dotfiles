{
  pkgs,
  inputs,
  username,
  ...
}:

{
  imports = [
    inputs.nixpkgs-xr.nixosModules.nixpkgs-xr
  ];

  nixpkgs.xr.enable = true;

  hm.home.file.".alsoftrc".text = ''
    hrtf = true
  '';

  boot.kernelPatches = [
    {
      name = "bigscreen beyond";
      patch = ./patching/beyondKernel.patch;
    }
    { # see https://wiki.nixos.org/wiki/VR#Applying_as_a_NixOS_kernel_patch
      name = "amdgpu-ignore-ctx-privileges";
      patch = pkgs.fetchpatch {
        name = "cap_sys_nice_begone.patch";
        url = "https://github.com/Frogging-Family/community-patches/raw/master/linux61-tkg/cap_sys_nice_begone.mypatch";
        hash = "sha256-Y3a0+x2xvHsfLax/uwycdJf3xLxvVfkfDVqjkxNaYEo=";
      };
    }
  ];

  programs.steam.extraCompatPackages = [
    pkgs.proton-ge-rtsp-bin
    pkgs.proton-ge-bin
  ];

  environment.systemPackages = with pkgs; [
    # index_camera_passthrough
    lighthouse-steamvr
    watchmanPairingAssistant

    openal
  ];

  users.users.${username}.extraGroups = [ "video" ];

  # Beyond udev rule
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="35bd", ATTRS{idProduct}=="0101", MODE="0666", GROUP="video"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="35bd", ATTRS{idProduct}=="0202", MODE="0666", GROUP="video"
  '';
}
