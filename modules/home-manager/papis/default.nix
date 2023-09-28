{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.papis = {
    enable = true;
  };
}
