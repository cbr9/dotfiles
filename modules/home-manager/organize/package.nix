{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.organize;
  toml = pkgs.formats.toml { };
in
{
  options = {
    programs.organize = {
      enable = mkEnableOption ''
        organize, a file butler for the poweruser
      '';

      package = mkOption {
        type = types.package;
        default = pkgs.organize;
        defaultText = literalExpression "pkgs.organize";
        description = "";
      };

      config = mkOption {
        type = toml.type;
        default = { };
        example = literalExpression ''
          {
            actions = {
              move = "$HOME/Downloads/{extension}/"
            };
            folders = [
              "$HOME/Downloads/"
            ];
            filters = [
              regex = ".*";
            ]
          }
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.configFile."organize/config.toml" = {
      enable = cfg.enable && cfg.config != { };
      source = toml.generate "config.toml" cfg.config;
    };
  };

  meta.maintainers = [ maintainers.cbr9 ];
}
