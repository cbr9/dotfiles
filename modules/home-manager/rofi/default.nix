{
  lib,
  pkgs,
  config,
  ...
}:
with pkgs; let
  cfg = config.programs.rofi;
  keyboard_layout_selector = pkgs.writeScriptBin "rofi_switch_keyboard_layout" ''
    ROFI_CMD="rofi -dmenu"
    KEYMAP_CACHE="${config.xdg.cacheHome}/keyboard-layout"
    LAYOUT_FILE="${config.xdg.configHome}/keyboard_layouts"

    msg="Current Layout: "$(setxkbmap -query | grep layout | cut -d':' -f2 | sed 's/ //g')

    selected=$(cat $LAYOUT_FILE | $ROFI_CMD -p "Keyboard Layout" -mesg "$msg" | awk '{print $1;}')

    if [ -n "$selected" ]; then
        setxkbmap "$selected"
        echo "$selected" > "$KEYMAP_CACHE"
    fi
  '';
in {
  stylix.targets.rofi.enable = false;
  home.packages = lib.mkIf cfg.enable [rofi-pulse-select keyboard_layout_selector];
  xdg.configFile."keyboard_layouts" = {
    enable = cfg.enable;
    text = ''
      us
      de
      es
    '';
  };

  programs.rofi = {
    enable = true;
    plugins = [rofi-emoji rofi-calc rofi-bluetooth];
    terminal = config.home.sessionVariables.TERMINAL;
    cycle = true;
    theme = "gruvbox-dark-hard";
    extraConfig = {
      modes = lib.concatStringsSep "," [
        "calc"
        "emoji"
        "drun"
        "filebrowser"
        "ssh"
      ];
      dpi = 120;
      ssh-client =
        if config.programs.kitty.enable
        then "kitten ssh"
        else "ssh";
      show-icons = true;
    };
  };
}
