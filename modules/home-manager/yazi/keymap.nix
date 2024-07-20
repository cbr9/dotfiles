{...}: {
  programs.yazi.keymap = {
    manager.prepend_keymap = [
      {
        on = ["e"];
        run = "open";
        desc = "Open the selected files";
      }
      {
        on = ["p"];
        run = "plugin --sync smart-paste";
        desc = "Paste into the hovered directory or CWD";
      }
      {
        on = ["F"];
        run = "plugin smart-filter";
        desc = "Smart filter";
      }
    ];
  };
}
