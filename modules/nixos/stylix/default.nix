{
  config,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    image = pkgs.fetchurl {
      url = "https://unsplash.com/photos/Hx8HaI4ERkA/download?ixid=M3wxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNzE5MTM4NDgyfA&force=true";
      sha256 = "sha256-0K3ei7oDuW3LFl1UPDHWvLMSARug3olCmGiKno9ejXI=";
    };
  };
  environment.variables = {
    WALLPAPER = config.stylix.image;
  };

  home-manager.users.cabero.stylix = {
    targets = {
      xfce.enable = false;
    };
  };
}
