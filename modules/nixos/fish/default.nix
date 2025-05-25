{ pkgs, ... }:
{
  config = {
    programs.fish.enable = true;
    environment.shells = [ pkgs.fish ];
    environment.pathsToLink = [ "/share/fish" ];
  };
}
