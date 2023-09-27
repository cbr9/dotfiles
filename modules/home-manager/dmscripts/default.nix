{pkgs, ...}:
with pkgs; let
  dmscripts = stdenv.mkDerivation rec {
    name = "dmscripts";
    version = "fe5c7d758a6784e547f1c7837f755a59a1985fbb";
    src = pkgs.fetchFromGitLab {
      owner = "dwt1";
      repo = "dmscripts";
      rev = version;
      hash = "sha256-wWXMHFgueOa8rzlQNfk6dUNC4HvZdSJz2yd1cPoj4lQ=";
    };

    buildInputs = [pandoc];
    buildPhase = ''
      echo "Linking scripts"
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp -a ${src}/scripts/* $out/bin
    '';
  };
in {
  home.packages = [dmscripts dmenu rofi fzf didyoumean dig libnotify];
  xdg.configFile."dmscripts/config" = {
    text =
      # bash
      ''
        #!/usr/bin/env bash
        DMENU="dmenu -i -l 20 -p"
        FMENU="fzf --bind=enter:replace-query+print-query --border=rounded --margin=5% --color=dark --height 100% --reverse --header=$(basename "$0") --info=hidden --header-first --prompt"
        RMENU="rofi -dmenu -p"
      '';
  };
}