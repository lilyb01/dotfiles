{ lib
, config
, ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  # cfg = config.custom.ssh;
in
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true; # TODO once i get fucking sops to do the thing
      X11Forwarding = true;
    };
    openFirewall = true;
  };
  environment.enableAllTerminfo = true;
}