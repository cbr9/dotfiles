{lib, ...}:
with lib; {
  programs.kitty = {
    enable = true;
    font.size = mkForce 15;
    shellIntegration.mode = "no-cursor";
    settings = {
      background_opacity = mkForce "0.90";
      window_padding_width = 5;
      cursor_blink_interval = 0;
    };
  };
}
