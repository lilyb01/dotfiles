{ ... }: {
  # TODO get name, email, & key from config or user
  config = {
    programs.git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user.name = "Lily B.";
        user.email = "lily@buny.plus";
        init.defaultBranch = "main";
        pull.ff = true;
        pull.rebase = true;
        rebase.autosquash = true;
        help.autoCorrect = "prompt";
        safe.directory = "*";
      };
    };

    programs.delta.enable = true;
    programs.delta.enableGitIntegration = true;

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