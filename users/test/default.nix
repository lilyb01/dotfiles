{
  pkgs,
  config,
  lib,
  ...
}: let
  #ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  #users.mutableUsers = false;

  users.users.test = {
    description = "This is a test, do not use!";
    shell = pkgs.zsh;
    extraGroups = [
      "audio"
      "video"
      "wheel"
      "networkmanager"
    ];
    isNormalUser = true;
    initialPassword = "weed";
    openssh.authorizedKeys.keys = [];

    # hashedPasswordFile = config.sops.secrets.lily-password.path;

    # packages = [pkgs.home-manager];
  };

  #sops.secrets.lily-password = {
  #  sopsFile = ../../secrets.yaml;
  #  neededForUsers = true;
  #};

  #home-manager.users.test = import ./${config.networking.hostName}.nix;

}
