{...}: {
  programs.lsd = {
    enable = true;
    enableAliases = false;
    settings = {
      blocks = [
        "permission"
        "user"
        "group"
        "size"
        "date"
        "name"
      ];
      classic = false;
      color = {
        when = "always";
        theme = "default";
      };
      date = "relative";
      ignore-globs = [
        ".git"
        ".hg"
      ];
      icons = {
        when = "always";
        theme = "fancy";
        separator = " ";
      };
      dereference = false;
      recursion = {
        enabled = false;
        depth = 5;
      };
      permission = "octal";
      sorting = {
        column = "name";
        reverse = false;
        dir-grouping = "first";
      };
      total-size = false;
      hyperlink = "always";
      symlink-arrow = "⇒";
      header = false;
      size = "short";
      indicators = false;
    };
  };
}
