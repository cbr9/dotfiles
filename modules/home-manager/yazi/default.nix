{pkgs, ...}: {
  programs.fish = {
    functions.fish_user_key_bindings = ''
      bind \cw 'set old_tty (stty -g); stty sane; ya; stty $old_tty; commandline -f repaint'
    '';
  };

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;

    keymap = {
      manager = {
        prepend_keymap = [
          {
            on = ["<C-d>" "a"];
            run = "shell --confirm '${pkgs.xdragon}/bin/dragon --all --and-exit --on-top ''$@'";
            desc = "Drag-and-drop all files at once";
          }
          {
            on = ["<C-d>" "o"];
            run = "shell --confirm '${pkgs.xdragon}/bin/dragon --on-top ''$@'";
            desc = "Drag-and-drop one file at a time";
          }
        ];
      };
    };

    settings = {
      manager = {
        sort_dir_first = true;
      };
      opener = {
        text = [
          {
            run = "hx $@";
            block = true;
          }
        ];
      };
      open = {
        rules = [
          {
            mime = "text/*";
            use = "text";
          }
          {
            mime = "image/*";
            use = "image";
          }
          {
            name = "*.json";
            use = "text";
          }
        ];
      };
    };
  };
}
