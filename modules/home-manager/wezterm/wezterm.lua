local wezterm = require 'wezterm';
wezterm.add_to_config_reload_watch_list(wezterm.config_dir)

local config = {}

config.keys = {
  { key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
  { key = '_', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
}

config.tiling_desktop_environments = {
  "X11 awesome"
}

config.color_scheme = 'Gruvbox dark, hard (base16)'
config.cursor_thickness = 2
config.enable_kitty_keyboard = true
config.font_size = 15
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.9
config.font = wezterm.font('JetBrains Mono', { weight = 'Medium', italic = false })

return config
