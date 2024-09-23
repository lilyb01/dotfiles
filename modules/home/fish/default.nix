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

    programs.bash = {
        interactiveShellInit = ''
            if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
            then
            shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
            exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
            fi
        '';
    };

    programs.starship = {
        enable = true;
        # Configuration written to ~/.config/starship.toml
        settings = {
        # add_newline = false;

        # character = {
        #   success_symbol = "[➜](bold green)";
        #   error_symbol = "[➜](bold red)";
        # };

        # package.disabled = true;
        };
    };

}
