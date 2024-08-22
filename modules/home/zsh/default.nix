{
    pkgs,
    inputs,
    lib,
    config,
    ...
}:

{

    programs.zsh = {
        enable = true;

        oh-my-zsh = {
            enable = true;
        };

        shellAliases = {
            "h" = "history";
            "c" = "clear";
            "s" = "sudo su";

            "fuck" = "_ !!";
            "sw" = "sudo nixos-rebuild switch --flake /home/lily/nix-config/.";
        };

        initExtra = ''
            hyfetch
        '';
    };

}