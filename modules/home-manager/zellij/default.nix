{
  lib,
  config,
  ...
}:
with lib; let
  boolToString = bool:
    if bool
    then "true"
    else "false";
in {
  options.programs.zellij = {
    allowOneInstance = mkEnableOption "Only allow one Zellij server at a time";
  };
  config = {
    stylix.targets.zellij.enable = false;
    home.shellAliases = lib.mkIf config.programs.zellij.enable {
      zj = "zellij";
    };
    home.sessionVariables = lib.mkIf config.programs.zellij.enable {
      ZELLIJ_AUTO_ATTACH = boolToString config.programs.zellij.allowOneInstance;
      ZELLIJ_AUTO_EXIT = boolToString config.programs.zellij.allowOneInstance;
    };
    programs.zellij = {
      enable = true;
      allowOneInstance = false;
      enableZshIntegration = config.programs.zellij.allowOneInstance;
      enableBashIntegration = config.programs.zellij.allowOneInstance;
      enableFishIntegration = config.programs.zellij.allowOneInstance;
      settings = {
        pane_frames = false;
        default_shell = "fish";
        default_layout = "compact";
        theme = "gruvbox-dark";
        ui.pane_frames.hide_session_name = config.programs.zellij.allowOneInstance;
      };
    };
  };
}
