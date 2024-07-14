local awful = require("awful")
local wibox = require("wibox")

awful.spawn("pamixer --unmute")

local volume = {
  LIMIT = 150,
  STEP = 5,
  CURRENT = 50,
  MUTED = false,
  WIDGET = wibox.widget {
    max_value = 150,
    value = 50,
    forced_width = 100,
    ticks = true,
    ticks_size = 2,
    ticks_gap = 1,
    color = "#fabd2f",
    border_width = 1,
    background_color = "#000000",
    border_color = "#fabd2f",
    margins = {
      left = 2,
    },
    -- bar_shape    = gears.shape.rounded_bar,
    widget = wibox.widget.progressbar
  }
}


function volume:toggle()
  awful.spawn("pamixer --toggle-mute")
  self.MUTED = not self.MUTED
  if self.MUTED then
    self.WIDGET.color = "#808080"
  else
    if self.CURRENT > 100 then
      self.WIDGET.color = "#ff0000"
    else
      self.WIDGET.color = "#fabd2f"
    end
  end
end

function volume:raise()
  awful.spawn.easy_async("pamixer --get-volume", function(stdout, _, _, _)
    self.CURRENT = tonumber(stdout)
    if self.CURRENT + self.STEP >= self.LIMIT then
      awful.spawn(string.format("pamixer --allow-boost --set-volume %s", self.LIMIT))
      self.CURRENT = self.LIMIT
    else
      awful.spawn(string.format("pamixer --increase %s --allow-boost", self.STEP))
      self.CURRENT = self.CURRENT + self.STEP
      if self.CURRENT > 100 and not self.MUTED then
          self.WIDGET.color = "#ff0000"
      end
    end
    self.WIDGET.value = self.CURRENT
  end)
end

function volume:lower()
  awful.spawn.easy_async("pamixer --get-volume", function(stdout, _, _, _)
    self.CURRENT = tonumber(stdout)
    if self.CURRENT - self.STEP > 0 then
      awful.spawn(string.format("pamixer --allow-boost --decrease %s", self.STEP))
      self.CURRENT = self.CURRENT - self.STEP
      if self.CURRENT <= 100 and not self.MUTED then
          self.WIDGET.color = "#fabd2f"
      end
    else
      self.CURRENT = 0
    end
    self.WIDGET.value = self.CURRENT
  end)
end

function volume:set(level)
    if level <= 0 then
      self.CURRENT = 0
    elseif level >= self.LIMIT then
      self.CURRENT = self.LIMIT
    else
      self.CURRENT = level
    end

    awful.spawn(string.format("pamixer --allow-boost --set %s", self.CURRENT))
    self.WIDGET.value = self.CURRENT
end

return volume

