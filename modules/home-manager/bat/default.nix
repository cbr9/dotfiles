{pkgs, ...}: {
  home.packages = with pkgs; [
    bat-extras.batdiff
    bat-extras.batgrep
    bat-extras.batpipe
    bat-extras.batwatch
    bat-extras.batman
    bat-extras.prettybat
  ];

  programs.bat = {
    enable = true;
    config = {};
    extraPackages = [];
    themes = {};
  };
}
