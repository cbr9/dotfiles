{...}: {
  programs.lsd = {
    enable = true;
    enableAliases = true;
    settings = {
      date = "relative";
      ignore-globs = [
        ".git"
        ".hg"
      ];
    };
  };
}
