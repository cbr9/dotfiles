{pkgs, ...}: {
  config = {
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
