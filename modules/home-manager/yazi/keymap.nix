{
  pkgs,
  lib,
  ...
}: let
  mkShellCmd = {
    confirm,
    block,
    script,
  }: let
    args = [
      (lib.optionalString confirm "--confirm")
      (lib.optionalString block "--block")
    ];
  in "shell ${lib.concatStringsSep " " args} '${script}'";
in {
  programs.yazi.keymap = {
    manager = {
      prepend_keymap = [
        {
          on = ["<C-d>" "a"];
          run = mkShellCmd {
            confirm = true;
            block = false;
            script = (
              # bash
              ''
                printf "%s\n" "$@" > /tmp/fx.tmp;
                ${pkgs.xdragon}/bin/dragon --all --and-exit --on-top --stdin < /tmp/fx.tmp
                rm /tmp/fx.tmp
              ''
            );
          };
          desc = "Drag-and-drop all files at once";
        }
        {
          on = ["<C-d>" "o"];
          run = mkShellCmd {
            confirm = true;
            block = false;
            script = (
              # bash
              ''
                printf "%s\n" "$@" > /tmp/fx.tmp;
                ${pkgs.xdragon}/bin/dragon --on-top --stdin < /tmp/fx.tmp
                rm /tmp/fx.tmp
              ''
            );
          };
          desc = "Drag-and-drop one file at a time";
        }
      ];
    };
  };
}
