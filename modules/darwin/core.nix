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
      hyfetch # highly important
    ];

    programs.zsh.enable = true;
  };
}