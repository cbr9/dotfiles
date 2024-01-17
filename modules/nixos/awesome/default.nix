{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.services.xserver.windowManager.awesome;
in {
  imports = [./config];
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
      maim
      pamixer
      brightnessctl
    ];

    environment.variables = {
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };

    home-manager.users.cabero = {
      services.betterlockscreen.package = pkgs.betterlockscreen.override {withDunst = !cfg.enable;};
      services.dunst.enable = lib.mkForce (!cfg.enable);

      xdg.configFile = {
        "autostart/autostart.sh".source = pkgs.writeShellScript "autostart.sh" ''
          ${lib.optionalString config.programs._1password-gui.enable "1password --silent &"}
          ${lib.optionalString config.home-manager.users.cabero.services.betterlockscreen.enable "betterlockscreen -u ${config.stylix.image} &"}
          ${lib.optionalString config.programs.kdeconnect.enable "kdeconnect-cli --refresh &"}
          ${pkgs.dropbox}/bin/dropbox &
        '';
      };
    };
  };
}
