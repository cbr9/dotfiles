{...}: {
  programs.atuin = {
    enable = true;
    flags = [
      "--disable-up-arrow"
    ];
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      style = "compact";
      inline_height = 20;
    };
  };
}
