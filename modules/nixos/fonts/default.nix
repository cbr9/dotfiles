{
  config,
  lib,
  pkgs,
  ...
}: let
  headless = config.sys.graphics.desktopProtocols == null;
in {
  config = lib.mkIf (!headless) {
    fonts.packages = with pkgs; [nerdfonts];
  };
}
