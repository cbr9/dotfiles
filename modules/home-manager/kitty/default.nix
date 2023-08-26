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
      cursor_blink_interval 0
    '';
  };
}
