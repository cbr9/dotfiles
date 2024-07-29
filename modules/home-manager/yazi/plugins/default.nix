{pkgs, ...}: let
  plugins-repo = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "0dc9dcd5794ca7910043174ec2f2fe3561016983";
    hash = "sha256-8RanvdS62IqkkKfswZUKynj34ckS9XzC8GYI9wkd3Ag=";
  };
in {
  programs.yazi.plugins = {
    smart-filter = "${plugins-repo}/smart-filter.yazi";
    parent-arrow = ./parent-arrow.yazi;
    chmod = "${plugins-repo}/chmod.yazi";
  };
}
