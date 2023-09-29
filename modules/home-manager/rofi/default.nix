{
  lib,
  pkgs,
  config,
  ...
}:
with pkgs; let
  cfg = config.programs.rofi;
  keyboard_layout_selector = pkgs.writeScriptBin "rofi_switch_keyboard_layout" ''
    ROFI_CMD="${cfg.package}/bin/rofi -dmenu"
    KEYMAP_CACHE="${config.xdg.cacheHome}/keyboard-layout"
    LAYOUT_FILE="${config.xdg.configHome}/keyboard_layouts"

    declare -Ag layouts
    layouts[us]=🇺🇸
    layouts[de]=🇩🇪
    layouts[es]=🇪🇸
    layouts[it]=🇮🇹
    layouts[gr]=🇬🇷
    layouts[ara]=🇦🇪

    current=$(${xorg.setxkbmap}/bin/setxkbmap -query | grep layout | cut -d':' -f2 | sed 's/ //g')
    flag=''${layouts[$current]}

    msg="Current Layout: $flag"

    selected=$(echo "''${!layouts[@]}" | xargs | tr " " "\n" | $ROFI_CMD -p "Keyboard Layout" -mesg "$msg" | awk '{print $1;}')


    if [ -n "$selected" ]; then
        ${xorg.setxkbmap}/bin/setxkbmap "$selected"
        echo "$selected" > "$KEYMAP_CACHE"
    fi
  '';
  extra-themes = pkgs.fetchFromGitHub {
    owner = "newmanls";
    repo = "rofi-themes-collection";
    rev = "a1bfac5627cc01183fc5e0ff266f1528bd76a8d2";
    sha256 = "0/0jsoxEU93GdUPbvAbu2Alv47Uwom3zDzjHcm2aPxY=";
  };
in {
  stylix.targets.rofi.enable = false;
  home.packages = lib.mkIf cfg.enable [
    rofi-pulse-select
    keyboard_layout_selector
    rofi-bluetooth
  ];

  programs.rofi = {
    enable = true;
    plugins = [rofi-emoji rofi-calc];
    terminal = config.home.sessionVariables.TERMINAL;
    cycle = true;
    theme = "${extra-themes}/themes/rounded-yellow-dark.rasi";
    extraConfig = {
      modes = lib.concatStringsSep "," [
        "calc"
        "emoji"
        "drun"
        "filebrowser"
        "ssh"
      ];
      matching = "prefix";
      sorting-method = "fzf";
      dpi = 120;
      ssh-client =
        if config.programs.kitty.enable
        then "kitten ssh"
        else "ssh";
      show-icons = true;
    };
  };
}
