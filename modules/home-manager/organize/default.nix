{config, ...}: let
  downloads = config.xdg.userDirs.download;
in {
  imports = [./package.nix];
  programs.organize = {
    enable = true;
    config = {
      rules = [
        {
          actions = [
            {
              type = "script";
              exec = "python";
              content = (
                # python
                ''
                  import shutil
                  new_path = "{path}".replace(" ", "-")
                  shutil.move("{path}", new_path)
                  print(new_path)
                ''
              );
            }
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
