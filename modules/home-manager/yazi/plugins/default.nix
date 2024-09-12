{pkgs, ...}: let
  plugins-repo = pkgs.fetchFromGitHub {
    owner = "yazi-rs";

    repo = "plugins";
    rev = "0b9f325";
    hash = "sha256-cJbqQ0QJi0izxWG8RS9r95xz8mYITBeCqxCN8bSXego=";
  };
in {
  programs.yazi.plugins = {
    smart-filter = "${plugins-repo}/smart-filter.yazi";
    parent-arrow = ./parent-arrow.yazi;
    chmod = "${plugins-repo}/chmod.yazi";
    git = "${plugins-repo}/git.yazi";
  };
}
