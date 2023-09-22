local wezterm = require("wezterm")
local config = {}

config.keys = {
  { key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
  { key = '_', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
}

config.tiling_desktop_environments = {
  "X11 awesome"
}

config.enable_kitty_graphics = true
config.set_environment_variables = {
  KITTY_PID = "wezterm" -- hack to make ctpv load images with the kitty protocol in lf
}

config.color_scheme = 'Gruvbox dark, hard (base16)'
config.cursor_thickness = 2
config.enable_kitty_keyboard = true
config.font_size = 15
config.window_padding = {
  left = 10,
  right = 0,
  top = 0,
  bottom = 0
}
config.enable_scroll_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.9
config.text_background_opacity = 0.6
config.font = wezterm.font('JetBrains Mono', { weight = 'Medium', italic = false })

return config
