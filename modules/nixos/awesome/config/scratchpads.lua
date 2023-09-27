local bling = require("bling")
local awful = require("awful")
local gears = require("gears")

local super = "Mod4"
local M = {}

local function build_scratchpad(command, rule)
  return bling.module.scratchpad {
    command = command,
    rule = rule,
    sticky                  = true,
    autoclose               = true,
    floating                = true,
    geometry                = { x = 360, y = 90, height = 900, width = 1200 },
    reapply                 = true,
    dont_focus_before_close = false,
  }
end


M.global_keys = gears.table.join()

return M
