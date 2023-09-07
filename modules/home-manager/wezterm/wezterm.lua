local wezterm = require 'wezterm';
wezterm.add_to_config_reload_watch_list(wezterm.config_dir)

local config = {
  keys = {
    { key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
    { key = '_', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
  },
  tiling_desktop_environments = {
    "X11 awesome"
  },
  color_scheme = 'Gruvbox dark, hard (base16)',
  cursor_thickness = 2,

  dpi = 120,
  enable_kitty_keyboard = true,
  font_size = 15,
  hide_tab_bar_if_only_one_tab = true,
  font = wezterm.font('JetBrains Mono', { weight = 'Medium', italic = false }),
}

return config

