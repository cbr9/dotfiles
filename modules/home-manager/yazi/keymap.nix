{pkgs, ...}: {
  programs.yazi.keymap = {
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
}
