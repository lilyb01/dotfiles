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
            source ~/.p10k.zsh
            hyfetch
        '';
        
        plugins = [   
            {                                                                                   
                name = "powerlevel10k";                                                           
                src = pkgs.zsh-powerlevel10k;                                                     
                file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";                         
            }
        ];
    };

}