{
  pkgs,
  config,
  lib,
  ...
}:
with pkgs;
with lib; let
  cfg = config.sys;
in {
  options.sys = {
    locale = mkOption {
      type = types.str;
      description = "The locale for the machine";
      default = "en_US.UTF-8";
    };

    timeZone = mkOption {
      type = types.str;
      description = "The timezone of the machine";
      default = "Europe/Berlin";
    };

    keyboardLayout = mkOption {
      type = types.str;
      description = "Keyboard layout";
      default = "us";
    };
  };

  config = with builtins; {
    i18n.defaultLocale = cfg.locale;
    time.timeZone = cfg.timeZone;
    services.xserver.layout = mkIf (elem "xorg" config.sys.graphics.desktopProtocols) cfg.keyboardLayout;
  };
}
