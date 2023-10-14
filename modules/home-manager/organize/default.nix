{config, ...}: let
  downloads = config.xdg.userDirs.download;
  documents = config.xdg.userDirs.documents;
in {
  imports = [./package.nix];
  programs.organize = {
    enable = true;
    config = {
      rules = [
        {
          folders = [downloads];
          actions = [
            {
              type = "move";
              to = documents;
              if_exists = "rename";
            }
          ];
          filters = [
            {
              type = "extension";
              extensions = ["pdf"];
            }
          ];
        }
        {
          actions = [
            {
              type = "move";
              to = "${downloads}/{extension}";
            }
          ];
          folders = ["${downloads}"];
          filters = [
            {
              type = "regex";
              patterns = [".*"];
            }
          ];
        }
      ];
    };
  };
}
