{ pkgs, ... }: {
  security = {
    doas = {
      enable = true;
      extraRules = [{
        users = ["lily"];
        keepEnv = true;
        persist = true;
      }];
    };
    sudo.enable = false;
  };

  environment.shellAliases.sudo = "${pkgs.doas-sudo-shim}/bin/sudo";
}