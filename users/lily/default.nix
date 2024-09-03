{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  #ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  secretspath = builtins.toString inputs.nix-secrets;
in {
  users.mutableUsers = true;

  users.users.lily = {
    description = "Lily";
    shell = pkgs.zsh;
    extraGroups = [
      "audio"
      "video"
      "wheel"
      "networkmanager"
    ];
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFaJdlmmN4c8KYWk8F1v715vMSUPN6jBCXcrZffEdmS/ lily@cantata"
    ];
    initialPassword = "changeme";
    #hashedPasswordFile = config.sops.secrets.pswd.path; #i can't figure this shit out it just won't let me log in lmfao

    # packages = [pkgs.home-manager];
  };

  home-manager.users.lily = import ./${config.networking.hostName}.nix;

}
