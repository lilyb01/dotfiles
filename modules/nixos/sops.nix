{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  secretspath = builtins.toString inputs.nix-secrets;
in {

  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    validateSopsFiles = false;
    age = {
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
    secrets = {
      pswd = {
        neededForUsers = true;
      };
      svce = { };
    };
  };
}