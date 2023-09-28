{
  pkgs,
  config,
  ...
}: let
  cfg = config.services.picom;
in {
  config = {
    environment.systemPackages = with pkgs; [picom];

    services.picom = {
      enable = true;
      fade = true;
      fadeDelta = 5;
      shadow = true;
      backend = "xrender";
      vSync = true;
      wintypes = {
        popup_menu = {opacity = cfg.menuOpacity;};
        dropdown_menu = {opacity = cfg.menuOpacity;};
        normal = {
          full-shadow = true;
        };
      };
    };
  };
}
