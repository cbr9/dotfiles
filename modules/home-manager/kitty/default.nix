{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;
    font.size = lib.mkForce 11;
    shellIntegration.mode = "no-cursor";
    extraConfig = ''
      background_opacity 0.90
      window_padding_width 5
      cursor_blink_interval 0
    '';
  };
}
