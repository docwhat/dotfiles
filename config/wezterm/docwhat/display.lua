local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("Cascadia Code")
config.font_size = 16.0

config.color_scheme = "Gruvbox dark, hard (base16)"

config.visual_bell = {
  fade_in_function = "Linear",
  fade_in_duration_ms = 15,
  fade_out_function = "EaseInOut",
  fade_out_duration_ms = 180,
}
config.audible_bell = "Disabled"

config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = true

-- Workaround for macOS shadow issue
-- https://github.com/wezterm/wezterm/issues/7275
config.window_decorations = "TITLE | RESIZE | MACOS_FORCE_DISABLE_SHADOW"
config.window_background_opacity = 0.98

return config
