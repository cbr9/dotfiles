{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.programs.zellij;
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
    home.shellAliases = lib.mkIf cfg.enable {
      zj = "zellij";
    };

    xdg.configFile."zellij/config.kdl" = {
      # the toKDL implementation in HM is clunky and confusing
      enable = cfg.enable;
      text = ( # kdl
        ''
          default_layout "compact"
          default_shell "fish"
          keybinds {
          	normal {
          		unbind "Alt l" "Alt h"
          	}
          }
          pane_frames false
          theme "gruvbox-dark"
          ui {
          	pane_frames {
          		hide_session_name ${boolToString cfg.allowOneInstance}
          	}
          }
        ''
      );
    };

    home.sessionVariables = lib.mkIf cfg.enable {
      ZELLIJ_AUTO_ATTACH = boolToString cfg.allowOneInstance;
      ZELLIJ_AUTO_EXIT = boolToString cfg.allowOneInstance;
    };
    programs.zellij = {
      enable = true;
      allowOneInstance = false;
      enableZshIntegration = cfg.allowOneInstance;
      enableBashIntegration = cfg.allowOneInstance;
      enableFishIntegration = cfg.allowOneInstance;
    };
  };
}
