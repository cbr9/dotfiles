{
  config,
  pkgs,
  ...
}: {
  programs.i3lock = {
    enable = true;
    package = pkgs.i3lock-color;
    u2fSupport = true;
  };

  home-manager.users.cabero = {
    services = {
      betterlockscreen = {
        enable = true;
        inactiveInterval = 10;
      };
    };

    gtk.iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };

    xdg.configFile = {
      "betterlockscreenrc" = {
        enable = config.home-manager.users.cabero.services.betterlockscreen.enable && config.programs.i3lock.u2fSupport;
        text = ''
          i3lockcolor_bin="/run/wrappers/bin/i3lock"
        '';
      };
    };
  };
}
