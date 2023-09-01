{
  lib,
  config,
  nixosConfig,
  ...
}:
with lib; {
  programs.kitty = {
    enable = nixosConfig != {};
    font.size = mkForce 15;
    shellIntegration.mode = "no-cursor";
    settings = {
      background_opacity = mkForce "0.90";
      confirm_os_window_close = 0;
      window_padding_width = 5;
      cursor_blink_interval = 0;
    };
  };

  xdg.configFile = mkIf config.programs.kitty.enable {
    # Make kitty open file hyperlinks with xdg-open when clicking
    # Since it doesn't seem to be the default behaviour
    "kitty/open-actions.conf".text = ''
      protocol file
      action launch --type=os-window xdg-open $FILE_PATH
    '';
  };
}
