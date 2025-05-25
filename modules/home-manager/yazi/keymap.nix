{
  ...
}:
{
  programs.yazi.keymap = {
    manager.prepend_keymap = [
      {
        on = [ "K" ];
        run = "plugin --sync parent-arrow --args=-1";
      }
      {
        on = [ "J" ];
        run = "plugin --sync parent-arrow --args=1";
      }
    ];
  };
}
