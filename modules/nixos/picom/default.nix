{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.sys.windowManager.i3.enable) {
    environment.systemPackages = with pkgs; [picom];

    services.picom = {
      enable = true;
      fade = true;
      fadeDelta = 5;
      shadow = true;
      backend = "xrender";
      vSync = true;
    };
  };
}
