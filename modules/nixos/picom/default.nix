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
        tooltip = {
          fade = true;
          shadow = true;
          opacity = 0.75;
          focus = true;
          full-shadow = false;
        };
        dock = {
          shadow = false;
          clip-shadow-above = true;
        };
        dnd = {shadow = false;};
        menu = {shadow = false;};
        popup_menu = {opacity = 0.8;};
        dropdown_menu = {opacity = 0.8;};
      };
    };
  };
}
