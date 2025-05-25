{
  config,
  pkgs,
  ...
}:
{
  # stylix = {
  #   enable = true;
  #   base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  #   image = pkgs.fetchurl {
  #     url = "https://unsplash.com/photos/VXHqJN52K6s/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8MzB8fHNldmlsbGF8ZW58MHwwfHx8MTcyNTA5MDYzMnww&force=true";
  #     sha256 = "sha256-V47OsoAFXD76CWqTpan+Cg0lBTNQa5/oFYZFFFWQRFc=";
  #   };
  # };
  # environment.variables = {
  #   WALLPAPER = config.stylix.image;
  # };

  home-manager.users.cabero = {
    # stylix = {
    #   targets = {
    #     xfce.enable = false;
    #   };
    # };
    # home.file.".wallpaper".source = config.stylix.image;
  };
}
