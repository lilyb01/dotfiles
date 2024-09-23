{
    pkgs,
    inputs,
    lib,
    config,
    ...
}:

{

    programs.fish = {
        enable = true;
        interactiveShellInit = ''
        set fish_greeting # Disable greeting
        '';
        plugins = [
        ];
    };

    programs.starship = {
        enable = true;
        # Configuration written to ~/.config/starship.toml
        settings = {
            format = "[░▒▓](#a3aed2)[  ](bg:#a3aed2 fg:#090c0c)[](bg:#769ff0 fg:#a3aed2)$directory[](fg:#769ff0 bg:#394260)$git_branch$git_status[](fg:#394260 bg:#212736)$nodejs$rust$golang$php[](fg:#212736 bg:#1d2230)$time[ ](fg:#1d2230)$character";
        # add_newline = false;

        # character = {
        #   success_symbol = "[➜](bold green)";
        #   error_symbol = "[➜](bold red)";
        # };

        # package.disabled = true;
        };
    };

}
