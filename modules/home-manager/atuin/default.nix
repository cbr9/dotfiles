{...}: {
  programs.atuin = {
    enable = true;
    enableNushellIntegration = false;
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
