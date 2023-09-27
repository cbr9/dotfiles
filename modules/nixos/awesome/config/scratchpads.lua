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

M.onepassword = build_scratchpad("1password", {instance = "1password"})
M.onepassword:turn_off()

M.todoist = build_scratchpad("todoist-electron", { instance = "todo" })
M.todoist:turn_off()

M.lf = build_scratchpad("kitty --class files -e lf", {instance = "files"});
M.lf:turn_off()


M.global_keys = gears.table.join(
    awful.key({ super }, "p", function() M.onepassword:toggle() end),
    awful.key({ super }, "t", function() M.todoist:toggle() end),
    awful.key({ super }, "l", function() M.lf:toggle() end)
)

return M
