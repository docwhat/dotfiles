local M = {}
local act = require("wezterm").action

M.leader = { key = "`", timeout_milliseconds = 1000 }
M.keys = {
  --
  -- Send LEADER when pressed twice
  { key = "`", mods = "LEADER", action = act.SendString("`") }, --
  -- Go to next tab
  { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
  { key = "n", mods = "SHIFT|LEADER", action = act.MoveTabRelative(1) }, --
  -- Go to previous tab
  { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) }, --
  { key = "p", mods = "SHIFT|LEADER", action = act.MoveTabRelative(-1) }, --
  -- Go to last tab
  { key = "Space", mods = "LEADER", action = act.ActivateLastTab }, --
  -- Open new tab with current directory
  { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") }, --
  -- Switch to tab N
  { key = "1", mods = "LEADER", action = act.ActivateTab(0) },
  { key = "2", mods = "LEADER", action = act.ActivateTab(1) },
  { key = "3", mods = "LEADER", action = act.ActivateTab(2) },
  { key = "4", mods = "LEADER", action = act.ActivateTab(3) },
  { key = "5", mods = "LEADER", action = act.ActivateTab(4) },
  { key = "6", mods = "LEADER", action = act.ActivateTab(5) },
  { key = "7", mods = "LEADER", action = act.ActivateTab(6) },
  { key = "8", mods = "LEADER", action = act.ActivateTab(7) },
  { key = "9", mods = "LEADER", action = act.ActivateTab(8) },
  { key = "0", mods = "LEADER", action = act.ActivateTab(9) }, --
  -- Pane Management
  {
    key = "-",
    mods = "LEADER",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "|",
    mods = "LEADER",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
  {
    key = "p",
    mods = "LEADER",
    action = act.PaneSelect({ alphabet = "", mode = "Activate" }),
  },
  { key = "Z", mods = "LEADER", action = act.TogglePaneZoomState }, --
  -- Copy Mode
  { key = "[", mods = "LEADER", action = act.ActivateCopyMode }, --
  -- Paste from clipboard
  { key = "]", mods = "LEADER", action = act.PasteFrom("Clipboard") }, --
  -- Reload config
  { key = "r", mods = "LEADER|SHIFT", action = act.ReloadConfiguration }, --
  -- Unicode Select
  {
    key = "u",
    mods = "LEADER",
    action = act.CharSelect({
      copy_on_select = true,
      copy_to = "ClipboardAndPrimarySelection",
    }),
  }, --
  -- Pass Thru emacs undo
  {
    key = "_",
    mods = "SHIFT|CTRL",
    action = act.SendKey({ key = "_", mods = "SHIFT|CTRL" }),
  }, --
  {
    key = "/",
    mods = "CTRL",
    action = act.SendKey({ key = "_", mods = "SHIFT|CTRL" }),
  }, --
  -- Make command+z send emacs undo.
  {
    key = "z",
    mods = "SUPER",
    action = act.SendKey({ key = "_", mods = "SHIFT|CTRL" }),
  }, --
  -- Missing command+plus to increase font.
  { key = "+", mods = "SUPER", action = act.IncreaseFontSize }, --
  -- Open Debug REPL
  { key = "d", mods = "LEADER|SHIFT", action = act.ShowDebugOverlay },
  -- Open Command Palette
  -- { key = "p", mods = "LEADER|SHIFT",       action = act.ActivateCommandPalette },
}

return M
