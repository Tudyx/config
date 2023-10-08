-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- By default wezterm use JetBrain Mono font (https://www.jetbrains.com/lp/mono/) which has ligature by default.
-- Uncomment this if you want to disable this.
-- config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'
config.color_scheme = 'Google (dark) (terminal.sexy)'
-- Default shell
config.default_prog= {'/usr/bin/fish'}
-- No padding around window
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
-- Replace fullscreen key bindings as there is a conflic with helix.
config.keys = {
  {
    key = 'Enter',
    mods = 'ALT',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 'F11',
    action = wezterm.action.ToggleFullScreen
  }
}

-- and finally, return the configuration to wezterm
return config

