{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  mkLfCmd = cmd: ''
    %{{
      ${cmd}
    }}
  '';
  mkShellCmd = cmd: ''
    ''${{
      ${cmd}
    }}
  '';
  mkAsyncCmd = cmd: ''
    &{{
      ${cmd}
    }}
  '';
  cfg = config.programs.lf;
in {
  programs.fish = mkIf cfg.enable {
    functions.fish_user_key_bindings = ''
      bind \cw 'set old_tty (stty -g); stty sane; lfcd; stty $old_tty; commandline -f repaint'
    '';
  };

  home.shellAliases = mkIf cfg.enable {
    lf = "lfcd";
  };

  xdg.configFile = {
    "fish/functions/lfcd.fish" = {
      enable = config.programs.fish.enable && cfg.enable;
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/gokcehan/lf/master/etc/lfcd.fish";
        sha256 = "sha256-wn9YEPtMqSHq7Ahr3KmG1YogiJQvKBOAO61pdPH6Pf0=";
      };
    };
    "fish/completions/lf.fish" = {
      enable = config.programs.fish.enable && cfg.enable;
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/gokcehan/lf/master/etc/lf.fish";
        sha256 = "sha256-jbcVK/MnthW08MM3bN0D439SZJdBvzRgf1TUGcgYDxE=";
      };
    };
    "lf/icons" = {
      enable = cfg.enable;
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example";
        sha256 = "sha256-QbWr5FxJZ5cJqS4zg+qyNK8JUG6SdLmaFoBuFXi0q0M=";
      };
    };
    "lf/colors" = {
      enable = cfg.enable;
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/gokcehan/lf/master/etc/colors.example";
        sha256 = "sha256-cYJlXuRjuotQ1aynPG5+UGK2nBBNg/6xRiGs2mBpKeY=";
      };
    };
  };

  home.packages = with pkgs;
    lib.mkIf cfg.enable [
      libreoffice
      ctpv
      atool # for archive files
      bat
      chafa # for image files on Wayland
      delta # for diff files
      ffmpeg
      ffmpegthumbnailer
      fontforge
      glow # for markdown files
      imagemagick
      jq # for json files
      ueberzug # for image files on X11
      transmission
    ];

  xdg.configFile."ctpv/config".text = lib.mkIf cfg.enable ''
    set forcekitty
    set forcekittyanim
  '';

  programs.lf = {
    enable = true;
    settings = {
      icons = true;
      hidden = true;
      ignorecase = true;
      incsearch = true;
    };
    commands = {
      open = mkShellCmd ''
        case $(file --mime-type -Lb "$fx") in
            text/*) $EDITOR "$fx";;
            application/json) $EDITOR "$fx";;
            image/*) ${pkgs.feh}/bin/feh "$fx";;
            *) xdg-open "$fx" > /dev/null 2> /dev/null &;;
        esac

      '';

      z = mkLfCmd ''
        result="$(zoxide query --exclude $PWD $@ | sed 's/\\/\\\\/g;s/"/\\"/g')"
        lf -remote "send $id cd \"$result\""
      '';

      zi = mkShellCmd ''
        result="$(zoxide query -i | sed 's/\\/\\\\/g;s/"/\\"/g')"
        lf -remote "send $id cd \"$result\""
      '';

      play = mkAsyncCmd "${pkgs.sox}/bin/play $f";
      stop-playing = mkAsyncCmd "pkill play";
      mkdir = mkLfCmd ''
        if [ $# -eq 0  ]; then
          printf "Directory Name: "
          read ans
          mkdir $ans
        else
          mkdir "$@"
        fi
      '';

      new = mkLfCmd ''
        if [ $# -eq 0  ]; then
          printf "Filename: "
          read ans
          touch $ans
        else
          touch "$@"
        fi
      '';

      select-files = mkAsyncCmd ''
        get_files() {
            if [ "$lf_hidden" = 'false' ]; then
                find "$PWD" -mindepth 1 -maxdepth 1 -type f -not -name '.*' -print0
            else
                find "$PWD" -mindepth 1 -maxdepth 1 -type f -print0
            fi |
            xargs -0 printf ' %q'
        }

        lf -remote "send $id :unselect; toggle $(get_files)"
      '';

      select-dirs = mkAsyncCmd ''
        get_dirs() {
            if [ "$lf_hidden" = 'false' ]; then
                find "$PWD" -mindepth 1 -maxdepth 1 -type d -not -name '.*' -print0
            else
                find "$PWD" -mindepth 1 -maxdepth 1 -type d -print0
            fi |
            xargs -0 printf ' %q'
        }

        lf -remote "send $id :unselect; toggle $(get_dirs)"
      '';

      yank-path = mkAsyncCmd ''
        copied=""
        for f in $fx; do
          path=$(realpath --no-symlinks "$f")
          copied+="$(echo -n "$path" | sd -s " " "\ ")" # escape whitespace
          copied+=" " # add a separator
        done

        copied=$(echo -n $copied | xargs) # trim last separator whitespace

        echo -n "$copied" | ${pkgs.xclip}/bin/xclip -selection clipboard
        lf -remote "send $id echo Copied \"$copied\" to clipboard"
      '';
    };

    previewer.source = "${pkgs.ctpv}/bin/ctpv";

    extraConfig = ''
      set cleaner ctpvclear
      &ctpv -s $id
      &ctpvquit $id
    '';

    keybindings = {
      gs = "git-restore";
      P = "play";
      DD = "delete $fs";
      x = "cut";
      J = ":updir; set dironly true; down; set dironly false; open";
      K = ":updir; set dironly true; up; set dironly false; open";
      o = ":open";
      y = "";
      yy = "copy";
      yp = "yank-path";
    };
  };
}
