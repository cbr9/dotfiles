{
  config,
  pkgs,
  ...
}: {
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    image = pkgs.fetchurl {
      url = "https://unsplash.com/photos/PdDBTrkGYLo/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8OTB8fGxpYnJhcnl8ZW58MHx8fHwxNzA2MDY1NDc1fDA&force=true";
      sha256 = "sha256-9th/+uhzySmVHY9pPLHd3B4R/ts5/iiTz6hCTskJFAw=";
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
