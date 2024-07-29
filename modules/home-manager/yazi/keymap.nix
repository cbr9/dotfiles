{pkgs, ...}: {
  programs.yazi.keymap = {
    manager.prepend_keymap = [
      {
        on = ["e"];
        run = "open";
        desc = "Open the selected files";
      }
      {
        on = ["F"];
        run = "plugin smart-filter";
        desc = "Smart filter";
      }
      {
        on = ["K"];
        run = "plugin --sync parent-arrow --args=-1";
      }
      {
        on = ["J"];
        run = "plugin --sync parent-arrow --args=1";
      }
      {
        on = ["C" "z"];
        run = "shell --confirm --orphan 'ouch compress --fast --yes \"$@\" compressed.zip'";
        desc = "Zip files";
      }
      {
        on = ["R" "j"];
        run = "shell --block --confirm 'just'";
        desc = "just";
      }
      {
        on = ["c" "m"];
        run = "plugin chmod";
        desc = "Chmod selected files";
      }
    ];
  };
}
