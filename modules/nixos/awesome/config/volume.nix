{config, ...}: let
  cfg = config.services.xserver.windowManager.awesome;
in {
  home-manager.users.cabero.xdg.configFile."awesome/volume.lua" = {
    enable = cfg.enable;
    text =
      # lua
      ''
        local awful = require("awful")

        local volume = {
          LIMIT = 150,
          STEP = 5,
        }

        function volume.toggle()
          awful.spawn("pamixer --toggle-mute")
        end

        function volume.raise()
          awful.spawn.easy_async("pamixer --get-volume", function(stdout, _, _, _)
            local current_volume = tonumber(stdout)
            if current_volume + volume.STEP >= volume.LIMIT then
              awful.spawn(string.format("pamixer --allow-boost --set-volume %s", volume.LIMIT))
            else
              awful.spawn(string.format("pamixer --increase %s --allow-boost", volume.STEP))
            end
          end)
        end

        function volume.lower()
          awful.spawn(string.format("pamixer --allow-boost --decrease %s", volume.STEP))
        end

        return volume
      '';
  };
}
