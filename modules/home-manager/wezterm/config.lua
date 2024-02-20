local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.enable_kitty_graphics = true
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.default_prog = {"nu", "-l"}
config.window_background_opacity = 0.9
config.text_background_opacity = 0.8
config.window_close_confirmation = "NeverPrompt"
config.color_scheme = 'GruvboxDarkHard'

config.keys = {
  {
    key = 'Enter',
    mods = 'CTRL',
    action = wezterm.action.ToggleFullScreen,
  },
}
return config
