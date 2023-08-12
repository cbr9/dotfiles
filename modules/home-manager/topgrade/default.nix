{...}: {
  home.shellAliases.tg = "topgrade";
  programs.topgrade = {
    enable = true;
    settings = {skip_notify = true;};
  };
}
