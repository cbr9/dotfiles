{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.programs.wezterm;
in
  with lib; {
    stylix.targets.wezterm.enable = false;
    programs.wezterm.enable = true;
    xdg.configFile."wezterm/wezterm.lua" = {
      enable = cfg.enable;
      source = ./wezterm.lua;
    };
    home.sessionVariables = mkIf cfg.enable {
      # TERMINAL = "${pkgs.wezterm}/bin/wezterm";
    };
  }
