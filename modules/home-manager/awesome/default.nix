{
  lib,
  pkgs,
  config,
  nixosConfig,
  ...
}:
with lib; {
  xsession.windowManager.awesome = {
    enable = nixosConfig != {};
    luaModules = with pkgs.luaPackages; [
      luarocks # is the package manager for Lua modules
      luadbi-mysql # Database abstraction layer
    ];
  };

  home.packages = with pkgs; mkIf config.xsession.windowManager.awesome.enable [pamixer brightnessctl dmenu];

  xdg.configFile = mkIf config.xsession.windowManager.awesome.enable {
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
