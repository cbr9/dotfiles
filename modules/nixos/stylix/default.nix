{
  config,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    image = pkgs.fetchurl {
      url = "https://unsplash.com/photos/godhydmIwgc/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8MTR8fGluZGlhbiUyMHdlZGRpbmd8ZW58MHx8fHwxNzIxNjMwNDQ5fDA&force=true";
      sha256 = "sha256-yfU0xGdNqNOTPobPht5BrI4tO8ifX5LQ3CpLzSII620=";
    };
  };
  environment.variables = {
    WALLPAPER = config.stylix.image;
  };

  home-manager.users.cabero = {
    stylix = {
      targets = {
        xfce.enable = false;
      };
    };
    home.file.".wallpaper".source = config.stylix.image;
  };
}
