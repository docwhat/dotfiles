local M = {}
local wezterm = require("wezterm")

M.font = wezterm.font("Cascadia Mono")
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

return M
