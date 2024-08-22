{ ... }: {
  # TODO get name, email, & key from config or user
  config = {
    programs.git = {
      enable = true;
      userName = "Lily B.";
      userEmail = "lily@buny.plus";
      extraConfig = {
        init.defaultBranch = "main";
        pull.ff = true;
        pull.rebase = true;
        rebase.autosquash = true;
        help.autoCorrect = "prompt";
      };
      delta.enable = true;
    };

    programs.gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };

    programs.lazygit = {
      enable = true;
      settings = { };
    };
  };
}