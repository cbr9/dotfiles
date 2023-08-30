{...}: {
  programs.lsd = {
    enable = true;
    enableAliases = false;
    settings = {
      date = "relative";
      ignore-globs = [
        ".git"
        ".hg"
      ];
    };
  };
}
