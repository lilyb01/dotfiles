# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  pkgs,
  ...
}: {

  users.users.lily = {
    name = "lily";
    home = "/Users/lily";
    isHidden = false;
    shell = pkgs.zsh;
  };

  home-manager.backupFileExtension = "backup";

  home-manager.users.lily = import ../../users/lily/Sonata.nix;

  services.nix-daemon.enable = true;
  system.stateVersion = 5;

}
