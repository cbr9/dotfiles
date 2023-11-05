{
  lib,
  pkgs,
  config,
  ...
}:
with pkgs; let
  extra-themes = pkgs.fetchFromGitHub {
    owner = "newmanls";
    repo = "rofi-themes-collection";
    rev = "a1bfac5627cc01183fc5e0ff266f1528bd76a8d2";
    sha256 = "0/0jsoxEU93GdUPbvAbu2Alv47Uwom3zDzjHcm2aPxY=";
  };
in {
  stylix.targets.rofi.enable = false;

  programs.rofi = {
    enable = true;
    plugins = [
      rofi-emoji
      rofi-calc
      rofi-power-menu
    ];
    terminal = config.home.sessionVariables.TERMINAL;
    cycle = true;
    theme = "${extra-themes}/themes/rounded-yellow-dark.rasi";
    extraConfig = {
      modes = lib.concatStringsSep "," [
        "calc"
        "emoji"
        "drun"
        "filebrowser"
        "ssh"
      ];
      matching = "regex";
      sorting-method = "normal";
      dpi = 120;
      ssh-client =
        if config.programs.kitty.enable
        then "kitten ssh"
        else "ssh";
      show-icons = true;
      case-sensitive = false;
    };
  };
}
