local M = {}
local wezterm = require("wezterm")

M.font = wezterm.font("Cascadia Code")
M.font_size = 16.0

M.color_scheme = "Gruvbox dark, hard (base16)"

M.visual_bell = {
  fade_in_function = "Linear",
  fade_in_duration_ms = 15,
  fade_out_function = "EaseInOut",
  fade_out_duration_ms = 180,
}
M.audible_bell = "Disabled"

M.use_fancy_tab_bar = true
M.tab_bar_at_bottom = true

-- Workaround for macOS shadow issue
-- https://github.com/wezterm/wezterm/issues/7275
M.window_decorations = "MACOS_FORCE_DISABLE_SHADOW"
M.window_background_opacity = 0.98

return M
