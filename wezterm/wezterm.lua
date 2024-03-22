-- Pull in the wezterm API
local wezterm = require 'wezterm'

local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.color_scheme = 'Catppuccin Mocha'

config.font_size = 14.0
config.font = wezterm.font 'JetBrainsMono Nerd Font Mono'

config.tab_bar_at_bottom = true

config.native_macos_fullscreen_mode = true

return config
