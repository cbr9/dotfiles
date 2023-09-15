{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.kitty;
  emojiPicker = pkgs.writeScriptBin "emoji" ''
    kitty +kitten unicode_input | xargs echo -n | kitty +kitten clipboard
  '';
in
  with lib; {
    stylix = {
      opacity.terminal = 0.9;
      fonts.sizes.terminal = 15;
      polarity = "dark";
      targets.kitty.variant256Colors = true;
    };

    home.sessionVariables = mkIf cfg.enable {
      TERMINAL = "kitty";
    };

    home.packages = mkIf cfg.enable [emojiPicker];

    programs.kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 0;
        window_padding_width = 5;
        cursor_blink_interval = 0;
      };
    };

    xdg.configFile = {
      # Make kitty open file hyperlinks with xdg-open when clicking
      # Since it doesn't seem to be the default behaviour
      "kitty/open-actions.conf" = {
        enable = cfg.enable;
        text = ''
          # Open text files without fragments in the editor
          protocol file
          mime text/*
          action launch --type=overlay hx ''${FILE_PATH}

          # Open any file with a fragment in helix, fragments are generated
          # by the hyperlink_grep kitten and nothing else so far.
          protocol file
          fragment_matches [0-9]+
          action launch --type=overlay --cwd=current hx ''${FILE_PATH}:''${FRAGMENT}

          protocol file
          mime inode/directory
          action launch --type=overlay lf ''${FILE_PATH}

          protocol file
          mime image/*
          action launch --type=overlay kitty +kitten icat --hold ''${FILE_PATH}

          protocol ssh
          # Open ssh URLs with ssh command
          action launch --type=os-window kitty +kitten ssh ''${URL}
        '';
      };
    };
  }
