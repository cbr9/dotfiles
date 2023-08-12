{
  config,
  lib,
  ...
}: let
  headless = config.sys.graphics.desktopProtocols == null;
  blocks = (
    lib.lists.optionals (config.sys.hardware.isLaptop) [
      {
        block = "battery";
        format = " $icon $percentage ";
      }
      {
        block = "backlight";
        missing_format = "";
      }
      {
        block = "net";
        format = " $icon  ";
        format_alt = " $icon { $ssid ($signal_strength)|Wired connection} ";
      }
    ]
    ++ lib.lists.optionals (config.sony.enable && config.networking.hostName != "deatcs001ws845") [
      {
        block = "net";
        device = "tun0";
        format = " $icon  ";
      }
    ]
    ++ lib.lists.optionals (config.services.mullvad-vpn.enable) [
      {
        block = "vpn";
        driver = "mullvad";
      }
    ]
    ++ [
      {
        block = "cpu";
        interval = 1;
        format = " $icon $utilization ";
      }
      {
        block = "temperature";
        format_alt = " $icon $average avg, $max max ";
        format = " $icon $average";
      }
      {
        block = "sound";
        max_vol = 150;
      }
      {
        block = "memory";
        format = " $icon $mem_used_percents ";
      }
      {
        block = "keyboard_layout";
        interval = 1;
      }
      {
        block = "time";
        interval = 60;
      }
    ]
  );
  types = lib.lists.forEach blocks (b: b.block);
  order = builtins.filter (s: builtins.elem s types) [
    "vpn"
    "cpu"
    "memory"
    "temperature"
    "battery"
    "backlight"
    "keyboard_layout"
    "sound"
    "net"
    "time"
  ];
in {
  config = lib.mkIf (!headless && config.sys.windowManager.i3.enable && (config.sys.windowManager.i3.bar == "i3status-rust")) {
    home-manager.users.cabero = {
      programs.i3status-rust = {
        enable = true;
        bars = {
          top = {
            theme = "gruvbox-dark";
            icons = "material-nf";
            blocks = lib.sortAttrsList ["block"] blocks order;
          };
        };
      };
    };
  };
}
