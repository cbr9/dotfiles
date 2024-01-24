{
  config,
  pkgs,
  ...
}: {
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    image = pkgs.fetchurl {
      url = "https://unsplash.com/photos/CJAVJ5SF6gA/download?ixid=M3wxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNzA2MDgwNzQxfA&force=true";
      sha256 = "sha256-1XBFa+lpCecpVvriMVrisPTRH9KZg+asGbdNjtULx3A=";
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
