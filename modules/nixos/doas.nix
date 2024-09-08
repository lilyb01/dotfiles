{ pkgs, ... }: {
  security = {
    doas.enable = true;
    sudo.enable = true;
  };

  # environment.shellAliases.sudo = "${pkgs.doas-sudo-shim}/bin/sudo";
}