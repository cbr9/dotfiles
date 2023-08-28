{
  pkgs,
  config,
  lib,
  nixosConfig,
  ...
}: {
  stylix.targets.alacritty.enable = false;

  programs.alacritty = {
    enable = nixosConfig != {};
    settings = let
      theme = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/cbr9/alacritty-theme/master/themes/gruvbox_dark.yaml";
        sha256 = "17qy1v2sgp69762mn2qa0bhnyz8f1x3krkdrqnqv5z0hnmfr5cy5";
      };
    in {
      import = [theme];
      shell = {
        program = "${pkgs.fish}/bin/fish";
        args = lib.mkIf (config.programs.zellij.allowOneInstance && config.programs.zellij.enable) [
          "-l"
          "-c"
          "zellij attach --index 0 || zellij"
        ];
      };
      window = {
        padding.x = 5;
        dynamic_padding = true;
      };
      font.size = 12.0;
    };
  };
}
