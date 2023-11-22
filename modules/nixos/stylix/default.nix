{
  config,
  pkgs,
  ...
}: {
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    image = pkgs.fetchurl {
      url = "https://unsplash.com/photos/aon-6I6Y6uQ/download?ixid=M3wxMjA3fDB8MXxhbGx8MjB8fHx8fHwyfHwxNzAwNjU2MjUwfA&force=true";
      sha256 = "sha256-aFcIkyvS6Z5eCiHlt9mOym2TPJ3ddH7FK4zp7XRrt28=";
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
