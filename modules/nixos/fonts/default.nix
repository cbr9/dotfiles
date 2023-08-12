{
  config,
  lib,
  pkgs,
  ...
}: let
  headless = config.sys.graphics.desktopProtocols == null;
in {
  config = lib.mkIf (!headless) {
    fonts = {
      fontDir.enable = true;
      packages = with pkgs; [nerdfonts];
    };
  };
}
