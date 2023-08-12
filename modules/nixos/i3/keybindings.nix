{
  lib,
  pkgs,
  config,
  ...
}: let
  home = config.home.homeDirectory;
  modifier = config.xsession.windowManager.i3.config.modifier;
  terminal = config.xsession.windowManager.i3.config.terminal;
in {
  xsession.windowManager.i3.config.keybindings = lib.mkOptionDefault {
    "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";
    "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 5";
    "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 5";
    "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
    "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set +5%";
    "${modifier}+Shift+j" = "focus down";
    "${modifier}+Shift+k" = "focus up";
    "${modifier}+Shift+l" = "focus right";
    "${modifier}+Shift+h" = "focus left";
    "${modifier}+q" = "kill";
    "${modifier}+Return" = "exec ${terminal}";
    "${modifier}+b" = "exec ${pkgs.firefox}/bin/firefox";
    "${modifier}+t" = "exec ${pkgs.todoist-electron}/bin/todoist-electron";
    "${modifier}+Shift+x" = "exec systemctl suspend";
    "${modifier}+l" = "exec ${pkgs.betterlockscreen}/bin/betterlockscreen -l";
    "${modifier}+Shift+d" = "exec setxkbmap -layout de";
    "${modifier}+Shift+u" = "exec setxkbmap -layout us";
    "${modifier}+Shift+e" = "exec setxkbmap -layout es";
    "${modifier}+Shift+q" = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";
    "Print" = "exec --no-startup-id ${pkgs.maim}/bin/maim \"${home}/Nextcloud/Pictures/Screenshots/$(date).jpg\"";
  };
}
