{pkgs, ...}: {
  home.packages = [pkgs.wezterm];
  home.sessionVariables.TERMINAL = "${pkgs.wezterm}/bin/wezterm";
}
