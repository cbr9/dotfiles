{config, ...}: {
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
      editor = config.home.sessionVariables.EDITOR;
    };
  };
}
