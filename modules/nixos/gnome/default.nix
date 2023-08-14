{config, ...}: {
  config = {
    services.xserver.desktopManager.gnome = {enable = config.home.username != "decabera";};
  };
}
