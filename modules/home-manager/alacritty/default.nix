{
  pkgs,
  config,
  nixosConfig,
  lib,
  ...
}: {
  programs.alacritty = {
    enable = nixosConfig != {};
    settings = {
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
    };
  };
}
