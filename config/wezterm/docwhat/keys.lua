local M = {}
local w = require("wezterm")
local act = w.action

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
    mods = "LEADER|CTRL",
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
  { key = "p", mods = "LEADER|SHIFT", action = act.ActivateCommandPalette },
  --
  -- Quick Open URLs
  {
    key = "o",
    mods = "LEADER",
    action = act({
      QuickSelectArgs = {
        label = "OPEN URL",
        patterns = {
          "https?://\\S+",
          "git://\\S+",
          "ssh://\\S+",
          "ftp://\\S+",
          "file://\\S+",
          "mailto://\\S+",
          [[h?t?t?p?s?:?/?/?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-zA-Z0-9]{2,6}\b[-a-zA-Z0-9@:%_\+.~#?&/=]*]],
          [[h?t?t?p?:?/?/?localhost:?[0-9]*/?\b[-a-zA-Z0-9@:%_\+.~#?&/=]*]],
        },
        action = w.action_callback(function(window, pane)
          local url = window:get_selection_text_for_pane(pane)
          w.log_info("opening: " .. url)
          w.open_with(url)
        end),
      },
    }),
  },
  --
  -- Quick Copy Line
  {
    key = "l",
    mods = "LEADER|SHIFT",
    action = act.QuickSelectArgs({ label = "COPY LINE", patterns = { "^.+$" } }),
  },
  --
  -- Quick Copy Git SHA1
  {
    key = "s",
    mods = "LEADER",
    action = act.QuickSelectArgs({ label = "COPY SHA1", patterns = { "[0-9a-f]{7,40}" } }),
  },

  { key = "UpArrow", mods = "SHIFT", action = act.ScrollToPrompt(-1) },
  { key = "DownArrow", mods = "SHIFT", action = act.ScrollToPrompt(1) },
  { key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-0.8) },
  { key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(0.8) },
}

M.key_tables = {
  copy_mode = {
    { key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
    { key = "Tab", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
    { key = "Enter", mods = "NONE", action = act.CopyMode("MoveToStartOfNextLine") },
    { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
    { key = "Space", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },

    -- cursor move of emacs like
    { key = "b", mods = "CTRL", action = act.CopyMode("MoveLeft") },
    { key = "f", mods = "CTRL", action = act.CopyMode("MoveRight") },
    { key = "n", mods = "CTRL", action = act.CopyMode("MoveDown") },
    { key = "p", mods = "CTRL", action = act.CopyMode("MoveUp") },
    { key = "a", mods = "CTRL", action = act.CopyMode("MoveToStartOfLineContent") },
    { key = "e", mods = "CTRL", action = act.CopyMode("MoveToEndOfLineContent") },
    { key = "w", mods = "CTRL", action = act.CopyMode("MoveBackwardWord") },

    -- cursor move of vim like
    { key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
    { key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
    { key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
    { key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },

    { key = "u", mods = "CTRL", action = act.CopyMode("PageUp") },
    { key = "d", mods = "CTRL", action = act.CopyMode("PageDown") },

    { key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
    { key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },
    { key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },

    { key = "f", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = false } }) },
    { key = "F", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
    { key = ",", mods = "NONE", action = act.CopyMode("JumpReverse") },
    { key = ";", mods = "NONE", action = act.CopyMode("JumpAgain") },

    { key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
    { key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
    { key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },

    { key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
    { key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },

    { key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
    { key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
    { key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
    { key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },
    { key = "M", mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },

    { key = "o", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },

    { key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
    { key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },
    { key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },
    { key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },

    { key = "q", mods = "NONE", action = act.CopyMode("Close") },
    {
      key = "y",
      mods = "NONE",
      action = act.Multiple({
        { CopyTo = "ClipboardAndPrimarySelection" },
        { CopyMode = "Close" },
      }),
    },
    { key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
    { key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },

    { key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
    { key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
    { key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
    { key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },

    { key = "LeftArrow", mods = "SHIFT", action = act.CopyMode("MoveBackwardSemanticZone") },
    { key = "RightArrow", mods = "SHIFT", action = act.CopyMode("MoveForwardSemanticZone") },
    { key = "DownArrow", mods = "SHIFT", action = act.ScrollToPrompt(1) },
    { key = "UpArrow", mods = "SHIFT", action = act.ScrollToPrompt(-1) },

    {
      key = "/",
      mods = "NONE",
      action = act.Multiple({ act.CopyMode("ClearPattern"), act.Search({ CaseInSensitiveString = "" }) }),
    },
    {
      key = "?",
      mods = "NONE",
      action = act.Multiple({ act.CopyMode("ClearPattern"), act.Search({ CaseInSensitiveString = "" }) }),
    },
  },
  search_mode = {
    { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
    -- Go back to copy mode when pressing enter, so that we can use unmodified keys like "n"
    -- to navigate search results without conflicting with typing into the search area.
    { key = "Enter", mods = "NONE", action = act.ActivateCopyMode },
    { key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
    { key = "u", mods = "CTRL", action = act.CopyMode("ClearPattern") },
  },
}

M.mouse_bindings = {
  --- Triple click on one character of the command output
  --  to select all of the output
  {
    event = { Down = { streak = 3, button = "Left" } },
    action = { SelectTextAtMouseCursor = "SemanticZone" },
    mods = "NONE",
  },
}

return M
