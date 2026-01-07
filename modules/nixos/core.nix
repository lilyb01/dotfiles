{ pkgs, ... }: {
  # Core packages/apps for all systems
  # TODO add options to toggle some if needed
  config = {
    environment.systemPackages = with pkgs; [
      tree
      wget
      curl
      git
      python3
      age
      wlroots
      hyfetch # highly important
      fastfetch
      ktailctl
      distrobox
      unrar
      htop
      btop
      ntfsprogs

      (yazi.override {
        _7zz = _7zz-rar;  # Support for RAR extraction
      })
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    # Allow users to mount removable drives
    services.udisks2.enable = true;

    programs.zsh.enable = true;
    programs.fish.enable = true;

    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images

    #programs.bash = {
    #  interactiveShellInit = ''
    #    if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    #    then
    #      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
    #      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    #    fi
    #  '';
    #};
  };
}
