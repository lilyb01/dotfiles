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
  };
}