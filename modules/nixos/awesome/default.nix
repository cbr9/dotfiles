{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.services.xserver.windowManager.awesome;
in {
  config = {
    services.xserver = {
      exportConfiguration = true;
      displayManager = {
        defaultSession = "none+awesome";
        lightdm = {
          enable = true;
          background = config.stylix.image;
        };
      };

      windowManager.awesome = {
        enable = true;
        luaModules = lib.attrValues {
          inherit (pkgs.luajitPackages) lgi ldbus luadbi-mysql luaposix;
        };
      };
    };

    environment.systemPackages = with pkgs; [
      dmenu
      todoist-electron
      maim
    ];

    environment.sessionVariables = {
      WALLPAPER = config.stylix.image;
      # Fix issue with java applications and tiling window managers.
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };

    home-manager.users.cabero = {
      services.betterlockscreen.package = pkgs.betterlockscreen.override {withDunst = !cfg.enable;};
      services.dunst.enable = lib.mkForce (!cfg.enable);

      xdg.configFile = {
        "autostart/autostart.sh".source =
          pkgs.writeShellScript "autostart.sh" ''
            "#!/bin/bash"
          ''
          + (lib.optionalString config.programs._1password-gui.enable "1password --silent &")
          + (lib.optionalString config.home-manager.users.cabero.services.nextcloud-client.enable "nextcloud --background &")
          + (lib.optionalString config.home-manager.users.cabero.services.betterlockscreen.enable "betterlockscreen -u ${config.stylix.image} &")
          + (lib.optionalString config.programs.kdeconnect.enable "kdeconnect-cli --refresh &");

        "awesome/rc.lua".source = ./config/rc.lua;
        "awesome/rubato".source = pkgs.fetchFromGitHub {
          owner = "andOrlando";
          repo = "rubato";
          rev = "a9181708863265eb4a36c722f664978ee50fe8a0";
          sha256 = "sha256-28NZK3F11heYsdElqC5fGxFTRTEJFbHodGej7NtGkJ4=";
        };
        "awesome/bling".source = pkgs.fetchFromGitHub {
          owner = "BlingCorp";
          repo = "bling";
          rev = "1f6bd0d5ef150a1801d20c69437ceff61d65fac5";
          sha256 = "sha256-0D2ck1qiA1ydLax45utJw1RhZZwhqg4KRoqgDFz4Gsg=";
        };
      };
    };
  };
}
