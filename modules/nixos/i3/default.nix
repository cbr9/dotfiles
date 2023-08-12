{
  lib,
  config,
  pkgs,
  ...
}:
with builtins;
with lib; let
  cfg = config.sys.windowManager;
in {
  options.sys.windowManager.i3 = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
    bar = mkOption {
      type = types.enum ["i3status" "i3status-rust"];
      default = "i3status-rust";
    };
  };

  config = mkIf cfg.i3.enable {
    services.xserver.windowManager.i3 = {
      enable = true;
    };

    # Fix issue with java applications and tiling window managers.
    environment.sessionVariables = {
      "_JAVA_AWT_WM_NONREPARENTING" = "1";
    };

    home-manager.users.cabero = let
      bg = "#282828";
      red = "#cc241d";
      white = "#ffffff";
      darkgray = "#1d2021";
      lightgray = "#bdae93";
    in {
      imports = [./keybindings.nix];
      home.packages = with pkgs; [
        file
        scrot
        imagemagick
        (mkIf (cfg.i3.bar == "i3status-rust") i3status-rust)
        (mkIf (cfg.i3.bar == "i3status") i3status)
        feh
        i3lock-color
      ];

      services.dunst = {
        enable = true;
      };

      xsession.windowManager.i3 = {
        enable = true;
        config = {
          modifier = "Mod4";
          window = {titlebar = false;};
          bars = [
            {
              fonts = {
                names = ["DejaVu Sans Mono" "FontAwesome5Free"];
                style = "Normal";
                size = 11.0;
              };
              # trayOutput = "none";
              position = "top";
              statusCommand = mkIf (cfg.i3.bar == "i3status-rust") "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";

              colors = {
                background = bg;
                statusline = lightgray;
                focusedWorkspace = {
                  border = lightgray;
                  background = lightgray;
                  text = bg;
                };
                inactiveWorkspace = {
                  border = darkgray;
                  background = darkgray;
                  text = white;
                };
                activeWorkspace = {
                  border = darkgray;
                  background = darkgray;
                  text = lightgray;
                };
                urgentWorkspace = {
                  border = red;
                  background = red;
                  text = bg;
                };
              };
            }
          ];
          menu = "${pkgs.dmenu-rs}/bin/dmenu_run";
          gaps = {
            inner = 5;
            outer = 5;
          };
          terminal = "${pkgs.alacritty}/bin/alacritty";
          startup = (
            [
              {
                command = "${pkgs.feh}/bin/feh --bg-fill ${config.sys.graphics.background}";
                always = true;
              }
              {
                command = "${pkgs.betterlockscreen}/bin/betterlockscreen -u ${config.sys.graphics.background}";
                always = true;
                notification = false;
              }
            ]
            ++ lib.optional config.services.mullvad-vpn.enable {
              command = "${config.services.mullvad-vpn.package}/bin/mullvad connect";
              always = true;
            }
            ++ lib.optional config.programs._1password-gui.enable {
              command = "${config.programs._1password-gui.package}/bin/1password --silent";
              always = true;
            }
            ++ lib.optional config.programs.kdeconnect.enable {
              command = "${config.programs.kdeconnect.package}/bin/kdeconnect-cli --refresh";
              always = true;
            }
          );
        };
      };
    };
  };
}
