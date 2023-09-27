{
  pkgs,
  config,
  ...
}: let
  cfg = config.services.clipmenu;
in {
  services.clipmenu = {
    enable = true;
    launcher = "rofi";
    package = pkgs.clipmenu.overrideAttrs (old: rec {
      version = "9735907061cc0a69734c887a35a048805539f5dc";
      src = pkgs.fetchFromGitHub {
        owner = "cdown";
        repo = "clipmenu";
        rev = version;
        sha256 = "d0MSCiUXF5bCmurj3rajf00MFgdogkH49dWVDa+kI+4=";
      };

      postFixup = with pkgs; ''
        sed -i "$out/bin/clipctl" -e 's,clipmenud\$,\.clipmenud-wrapped\$,'

        wrapProgram "$out/bin/clipmenu" \
          --prefix PATH : "${lib.makeBinPath [xsel]}" \
          --set CM_LAUNCHER ${cfg.launcher}

        wrapProgram "$out/bin/clipmenud" \
          --set PATH "${lib.makeBinPath [clipnotify coreutils gawk util-linux xdotool xsel]}"
      '';
    });
  };
}
