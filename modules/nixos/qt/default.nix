{
  config,
  pkgs,
  lib,
  ...
}: let
  headless = config.sys.graphics.desktopProtocols == null;
in {
  config = lib.mkIf (!headless) {
    environment.systemPackages = with pkgs; [breeze-qt5];
  };
}
