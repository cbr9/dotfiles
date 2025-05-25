{
  config,
  pkgs,
  ...
}:
let
  downloads = config.xdg.userDirs.download;
  pictures = config.xdg.userDirs.pictures;
  videos = config.xdg.userDirs.videos;
  python = "${pkgs.python312Full}/bin/python3";
  replace_spaces = {
    type = "script";
    exec = python;
    content = (
      # python
      ''
        import shutil
        new_path = "{{path}}".replace(" ", "-")
        shutil.move("{{path}}", new_path)
        print(new_path)
      '');
  };
in
{
  imports = [ ./package.nix ];
  programs.organize = {
    enable = true;
    config = {
      rules = [
        {
          actions = [
            {
              type = "move";
              to = "${downloads}/{{extension}}/";
            }
          ];
          folders = [ { path = downloads; } ];
          filters = [
            {
              type = "group";
              filters = [
                {
                  type = "regex";
                  patterns = [ ".*" ];
                }
              ];
            }
          ];
        }
        {
          actions = [
            replace_spaces
            {
              type = "move";
              to = videos;
              confirm = true;
            }
          ];
          folders = [
            {
              path = downloads;
              max_depth = 0;
            }
          ];
          filters = [
            {
              type = "mime";
              types = [ "video/*" ];
            }
          ];
        }
        {
          actions = [
            replace_spaces
            {
              type = "move";
              to = "${pictures}/Unsplash/";
            }
          ];
          filters = [
            {
              type = "regex";
              patterns = [
                ".*unsplash"
              ];
            }
          ];
          folders = [ { path = downloads; } ];
        }
      ];
    };
  };
}
