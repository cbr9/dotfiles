{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.services.xserver.windowManager.awesome;
in {
  imports = [./rc.nix ./helpers.nix ./keyboard-layout-indicator.nix];
  config = {
    services.xserver = {
      displayManager = {
        defaultSession = "none+awesome";
        lightdm = {
          enable = true;
          background = config.stylix.image;
        };
      };

      windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
          luarocks # is the package manager for Lua modules
          luadbi-mysql # Database abstraction layer
        ];
      };
    };

    # Fix issue with java applications and tiling window managers.
    environment.sessionVariables._JAVA_AWT_WM_NONREPARENTING = "1";

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
