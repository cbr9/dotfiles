{config, ...}: let
  downloads = "${config.home.homeDirectory}/Downloads";
  pictures = "${config.home.homeDirectory}/Pictures";
in {
  imports = [./package.nix];
  programs.organize = {
    enable = false;
    config = {
      rules = [
        {
          actions = [
            {
              type = "move";
              to = "${pictures}/Screenshots";
            }
          ];
          filters = [
            {
              type = "filename";
              contains = "screenshot";
              case_sensitive = false;
            }
            {
              type = "mime";
              types = ["image/*"];
            }
          ];
          folders = [downloads pictures];
        }
        {
          folders = [downloads pictures];
          actions = [
            {
              type = "move";
              to = "${pictures}/Wallpapers/";
              if_exists = "overwrite";
            }
          ];
          filters = [
            {
              type = "filename";
              contains = "unsplash";
              case_sensitive = false;
            }
            {
              type = "mime";
              types = ["image/*"];
            }
          ];
        }
        {
          actions = [
            {
              type = "copy";
              to = "${config.home.homeDirectory}/Music/{parent.filename}/{filename}";
              if_exists = "overwrite";
            }
          ];
          folders = [
            {
              path = downloads;
              options.recursive = 2;
            }
          ];
          filters = [
            {
              type = "extension";
              extensions = ["flac" "mp3" "m3u"];
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
