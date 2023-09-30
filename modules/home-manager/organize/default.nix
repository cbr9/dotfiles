{config, ...}: let
  downloads = config.xdg.userDirs.download;
  pictures = config.xdg.userDirs.pictures;
  documents = config.xdg.userDirs.documents;
  music = config.xdg.userDirs.music;
in {
  imports = [./package.nix];
  programs.organize = {
    enable = false;
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
