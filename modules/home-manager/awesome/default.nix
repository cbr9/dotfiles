{
  lib,
  pkgs,
  config,
  nixosConfig,
  ...
}:
with lib; let
  cfg = config.xsession.windowManager.awesome;
in {
  xsession.windowManager.awesome = {
    enable = nixosConfig != {} && nixosConfig.services.xserver.windowManager.awesome.enable;
    luaModules = with pkgs.luaPackages; [
      luarocks # is the package manager for Lua modules
      luadbi-mysql # Database abstraction layer
    ];
  };

  home = mkIf cfg.enable {
    packages = with pkgs; [pamixer brightnessctl dmenu maim todoist-electron];
    # Fix issue with java applications and tiling window managers.
    sessionVariables = {
      "_JAVA_AWT_WM_NONREPARENTING" = "1";
    };
  };

  services = {
    betterlockscreen = {
      enable = cfg.enable;
      package = pkgs.betterlockscreen.override {withDunst = !cfg.enable;};
      inactiveInterval = 5;
    };

    caffeine.enable = cfg.enable;
  };

  xdg.configFile = mkIf cfg.enable {
    "betterlockscreenrc" = {
      enable = config.services.betterlockscreen.enable;
      text = ''
        i3lockcolor_bin="/run/wrappers/bin/i3lock"
      '';
    };
    "awesome/helpers.lua".source = ./helpers.lua;
    "awesome/keyboard-layout-indicator.lua".source = ./keyboard-layout-indicator.lua;
    "awesome/theme.lua".source = pkgs.substituteAll {
      name = "theme.lua";
      src = ./theme.lua;
      wallpaper = config.stylix.image;
    };
    "awesome/rc.lua".source = pkgs.substituteAll {
      name = "rc.lua";
      src = ./rc.lua;
      wallpaper = config.stylix.image;
    };
  };

  # if ${boolToString nixosConfig.programs._1password-gui.enable} then
  #   awful.spawn("${nixosConfig.programs._1password-gui.package}/bin/1password --silent")
  # end

  # if ${boolToString nixosConfig.programs.kdeconnect.enable} then
  #   awful.spawn("${nixosConfig.programs.kdeconnect.package}/bin/kdeconnect-cli --refresh")
  # end

  # if ${boolToString nixosConfig.services.mullvad-vpn.enable} then
  #   awful.spawn("${nixosConfig.services.mullvad-vpn.package}/bin/mullvad connect")
  # end
}
