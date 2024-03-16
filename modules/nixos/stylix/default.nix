{
  config,
  pkgs,
  ...
}: {
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    image = pkgs.fetchurl {
      url = "https://unsplash.com/photos/AXLn5gBQeck/download?ixid=M3wxMjA3fDB8MXxhbGx8MXx8fHx8fDJ8fDE3MTA1ODgzODF8&force=true";
      sha256 = "sha256-WMj2hLrOpVjXkqHfLpFG5GxBESS0bmg2XljJcTKch4U=";
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
