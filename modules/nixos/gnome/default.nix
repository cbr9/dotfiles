{config, ...}: {
  config = {
    services.xserver.desktopManager.gnome = {enable = true;};
    services.gnome.gnome-browser-connector.enable = config.services.xserver.desktopManager.gnome.enable;
  };
}
