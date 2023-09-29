{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.papis = {
    enable = true;
    settings = {
      editor = "hx";
      file-browser = "lf";
      add-edit = true;
    };
  };
}
