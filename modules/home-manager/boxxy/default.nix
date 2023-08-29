{...}: {
  programs.boxxy = {
    enable = true;
    rules = [
      {
        name = "Thunderbird";
        target = "~/.thunderbird";
        rewrite = "~/.local/share/thunderbird";
      }
    ];
  };
}
