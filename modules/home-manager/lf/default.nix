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

  xdg.desktopEntries.lf = mkIf (cfg.enable && (builtins.hasAttr "TERMINAL" config.home.sessionVariables)) {
    name = "lf";
    genericName = "lf";
    type = "Application";
    exec = "${config.home.sessionVariables.TERMINAL} -e ${cfg.package}/bin/lf";
    icon = "utilities-terminal";
    terminal = false;
    categories = ["ConsoleOnly" "System" "FileTools" "FileManager"];
    mimeType = ["inode/directory"];
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

  xdg.configFile."ctpv/config" = {
    enable = cfg.enable && cfg.previewer.source == "${pkgs.ctpv}/bin/ctpv";
    text = ''
      set forcekitty
      set forcekittyanim
    '';
  };

  programs.lf = {
    enable = true;
    settings = {
      sixel = true;
      icons = true;
      hidden = true;
      ignorecase = true;
      incsearch = true;
    };
    commands = {
      toggle_preview = (
        mkLfCmd
        # bash
        ''
          if [ "$lf_preview" = "true" ]; then
              lf -remote "send $id :set preview false; set ratios 1:5"
          else
              lf -remote "send $id :set preview true; set ratios 1:2:3"
          fi
        ''
      );

      fzf-search = (
        mkShellCmd
        # bash
        ''
          RG_PREFIX="rg --no-column --no-line-number --no-heading --multiline --trim --color=always --smart-case "
          res="$(
            FZF_DEFAULT_COMMAND="$RG_PREFIX \'\'" \
              fzf --bind "change:reload:$RG_PREFIX {q} || true" \
              --ansi --layout=reverse --header 'Search in files' \
              | cut -d':' -f1 | sed 's/\\/\\\\/g;s/"/\\"/g'
          )"
          [ -n "$res" ] && lf -remote "send $id select \"$res\""
        ''
      );

      fzf-jump = (
        mkShellCmd
        # bash
        ''
          res="$(fd --max-depth 1 | fzf --reverse --header='Jump to location')"
          if [ -n "$res" ]; then
              if [ -d "$res" ]; then
                  cmd="cd"
              else
                  cmd="select"
              fi
              res="$(printf '%s' "$res" | sed 's/\\/\\\\/g;s/"/\\"/g')"
              lf -remote "send $id $cmd \"$res\""
          fi
        ''
      );

      on-cd = (
        mkAsyncCmd
        # bash
        ''
          # '&' commands run silently in background (which is what we want here),
          # but are not connected to stdout.
          # To make sure our escape sequence still reaches stdout we pipe it to /dev/tty
          printf "\033]0; $(pwd | sed "s|$HOME|~|") - lf\007" > /dev/tty
        ''
      );
      open = (
        mkShellCmd
        # bash
        ''
          case $(file --mime-type -Lb "$fx") in
              text/*) $EDITOR "$fx";;
              application/json) $EDITOR "$fx";;
              image/*) ${pkgs.feh}/bin/feh "$fx";;
              *) xdg-open "$fx" > /dev/null 2> /dev/null &;;
          esac
        ''
      );

      z = (
        mkLfCmd
        # bash
        ''
          result="$(zoxide query --exclude $PWD $@ | sed 's/\\/\\\\/g;s/"/\\"/g')"
          lf -remote "send $id cd \"$result\""
        ''
      );

      zi = (
        mkShellCmd
        # bash
        ''
          result="$(zoxide query -i | sed 's/\\/\\\\/g;s/"/\\"/g')"
          lf -remote "send $id cd \"$result\""
        ''
      );

      play = mkAsyncCmd "${pkgs.sox}/bin/play $f";
      stop-playing = (
        mkAsyncCmd
        # bash
        ''
          pkill play
        ''
      );

      mkdir = (
        mkLfCmd
        # bash
        ''
          if [ $# -eq 0  ]; then
            printf "Directory Name: "
            read ans
            mkdir $ans
          else
            mkdir "$@"
          fi
        ''
      );

      new = (
        mkLfCmd
        # bash
        ''
          if [ $# -eq 0  ]; then
            printf "Filename: "
            read ans
            touch $ans
          else
            touch "$@"
          fi
        ''
      );

      select-files = (
        mkAsyncCmd
        # bash
        ''
          get_files() {
              if [ "$lf_hidden" = 'false' ]; then
                  find "$PWD" -mindepth 1 -maxdepth 1 -type f -not -name '.*' -print0
              else
                  find "$PWD" -mindepth 1 -maxdepth 1 -type f -print0
              fi |
              xargs -0 printf ' %q'
          }

          lf -remote "send $id :unselect; toggle $(get_files)"
        ''
      );

      select-dirs = (
        mkAsyncCmd
        # bash
        ''
          get_dirs() {
              if [ "$lf_hidden" = 'false' ]; then
                  find "$PWD" -mindepth 1 -maxdepth 1 -type d -not -name '.*' -print0
              else
                  find "$PWD" -mindepth 1 -maxdepth 1 -type d -print0
              fi |
              xargs -0 printf ' %q'
          }

          lf -remote "send $id :unselect; toggle $(get_dirs)"
        ''
      );

      bulk-rename = (
        mkShellCmd
        # bash
        ''
          printf '%s\n' "$fx" | ${pkgs.moreutils}/bin/vidir -
        ''
      );

      yank-dirname = (
        mkShellCmd
        # bash
        ''
          dirname -- "$fx" | head -c-1 | xclip -i -selection clipboard
        ''
      );

      yank-path = (
        mkShellCmd
        # bash
        ''
          printf '%s' "$fx" | xclip -i -selection clipboard
        ''
      );

      yank-filename = (
        mkShellCmd
        # bash
        ''
          basename -a -- $fx | head -c-1 | xclip -i -selection clipboard
        ''
      );

      yank-filestem = (
        mkShellCmd
        # bash
        ''
          echo "$fx" |
            xargs -r -d '\n' basename -a |
            awk -e '{
              for (i=length($0); i > 0; i--) {
                if (substr($0, i, 1) == ".") {
                  if (i == 1) print $0
                  else print substr($0, 0, i-1)

                  break
                }
              }

              if (i == 0)
                print $0
            }' |
            if [ -n "$fs" ]; then cat; else tr -d '\n'; fi |
            xclip -i -selection clipboard
        ''
      );
    };

    previewer.source = "${pkgs.ctpv}/bin/ctpv";

    extraConfig = ( # bash
      ''
        on-cd
        set cleaner ctpvclear
        &ctpv -s $id
        &ctpvquit $id
      ''
    );

    keybindings = {
      P = "play";
      DD = "delete $fs";
      x = "cut";
      J = ":updir; set dironly true; down; set dironly false; open";
      K = ":updir; set dironly true; up; set dironly false; open";
      o = ":open";
      "<f-2>" = "bulk-rename";
      tp = "toggle_preview";

      "<c-f>" = "fzf-jump";
      gs = "fzf-search";
      # unmap the default rename keybinding
      r = "";
      i = " rename";
      I = " :rename; cmd-home";
      A = " :rename; cmd-end";
      c = " :rename; cmd-delete-home";
      C = " :rename; cmd-end; cmd-delete-home";

      # paths
      y = "";
      yy = "copy";
      yd = "yank-dirname";
      yp = "yank-path";
      yf = "yank-filename";
      ys = "yank-filestem";
    };
  };
}
