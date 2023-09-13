{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.kitty;
  emojiPicker = pkgs.writeScriptBin "emoji" ''
    kitty +kitten unicode_input | xargs echo -n | kitty +kitten clipboard
  '';
in
  with lib; {
    stylix = {
      opacity.terminal = 0.9;
      fonts.sizes.terminal = 15;
      polarity = "dark";
      targets.kitty.variant256Colors = true;
    };

    home.sessionVariables = mkIf cfg.enable {
      TERMINAL = "kitty";
    };

    home.packages = mkIf cfg.enable [emojiPicker];

    programs.kitty = {
      enable = true;
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
