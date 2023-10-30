{pkgs, ...}: {
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    image = pkgs.fetchurl {
      url = "https://unsplash.com/photos/dGMcpbzcq1I/download?ixid=M3wxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjk4MDc3NTI1fA&force=true";
      sha256 = "sha256-wVD+G1JRmDW/iDkejTtkkd3Ujs04oL+C5JSZNT5kdFo=";
    };
  };

  home-manager.users.cabero.stylix = {
    targets = {
      xfce.enable = false;
    };
  };
}
