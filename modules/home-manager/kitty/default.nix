{
  lib,
  config,
  nixosConfig,
  ...
}: let
  cfg = config.programs.kitty;
in
  with lib; {
    stylix = {
      opacity.terminal = 0.7;
      polarity = "dark";
      targets.kitty.variant256Colors = true;
    };

    programs.kitty = {
      enable = nixosConfig != {};
      font = {
        size = mkForce 15;
      };
      shellIntegration.mode = "no-cursor";
      settings = {
        confirm_os_window_close = 0;
        window_padding_width = 5;
        cursor_blink_interval = 0;
      };
    };

    xdg.configFile = {
      # Make kitty open file hyperlinks with xdg-open when clicking
      # Since it doesn't seem to be the default behaviour
      "kitty/open-actions.conf" = {
        enable = cfg.enable;
        text = ''
          protocol file
          action launch --type=os-window xdg-open $FILE_PATH
        '';
      };
    };
  }
