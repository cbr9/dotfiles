{pkgs, ...}: {
  home.packages = [pkgs.wezterm];
  # home.sessionVariables.TERMINAL = "${pkgs.wezterm}/bin/wezterm";
  xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;
}
