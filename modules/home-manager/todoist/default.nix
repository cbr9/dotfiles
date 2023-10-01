{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.programs.todoist;
  json = pkgs.formats.json {};
in {
  options = with lib; {
    programs.todoist = {
      enable = mkEnableOption "Enable todoist";
      config = mkOption {
        type = json.type;
        default = {};
      };
    };
  };

  config = {
    home.packages = with pkgs; lib.mkIf cfg.enable [todoist todoist-electron];
    home.sessionVariables = lib.mkIf cfg.enable {
      TODOIST_TOKEN = "op://Personal/Todoist/api-key";
    };
    xdg.configFile."todoist/config.json" = {
      enable = cfg.enable && cfg.config != {};
      text = builtins.toJSON cfg.config;
    };
    programs.todoist = {
      enable = true;
      config = {
        color = true;
      };
    };
  };
}
