{
  config,
  pkgs,
  ...
}:
{
  programs.i3lock = {
    enable = true;
    package = pkgs.i3lock-color;
    u2fSupport = true;
  };

  home-manager.users.cabero = {
    services = {
      betterlockscreen = {
        enable = true;
        inactiveInterval = 5;
      };
    };

    xdg.configFile = {
      "betterlockscreen/betterlockscreenrc" = {
        enable =
          config.home-manager.users.cabero.services.betterlockscreen.enable
          && config.programs.i3lock.u2fSupport;
        source = ./betterlockscreenrc;
      };
    };
  };
}
