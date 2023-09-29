{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.programs.papis;
in {
  options = with lib; {
    programs.papis.package = mkOption {
      type = types.package;
      default = pkgs.papis;
      defaultText = literalExpression "pkgs.papis";
      description = "";
    };
  };
  config = {
    home.packages = [cfg.package];
    programs.papis = {
      enable = true;
      settings = {
        editor = "hx";
        file-browser = "lf";
        add-edit = true;
        add-download-files = true;
      };
      libraries = {
        papers = {
          isDefault = true;
          settings = {
            dir = "${config.xdg.userDirs.documents}/Library/Papers";
          };
        };
      };
    };
  };
}
