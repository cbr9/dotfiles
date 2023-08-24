{config, ...}: {
  config = {
    services.xserver.desktopManager.gnome.enable = false;
    services.gnome.gnome-browser-connector.enable = config.services.xserver.desktopManager.gnome.enable;
  };
}
