-- https://www.hammerspoon.org/
-- Getting Started Guide:
--    https://www.hammerspoon.org/go/
-- Learn X in Y minutes; where X = Lua:
--    https://learnxinyminutes.com/docs/lua/
-- luacheck: globals hs spoon
-- Make the console dark
hs.console.darkMode(true)
if hs.console.darkMode() then
  hs.console.outputBackgroundColor({ white = 0 })
  hs.console.consoleCommandColor({ white = 1 })
  hs.console.consolePrintColor({ white = 1 })
  hs.console.alpha(1)
end

-- luacheck: globals hyper shift_hyper Install
local hyper = { "cmd", "alt", "ctrl" }
-- local shift_hyper = {"cmd", "alt", "ctrl", "shift"}
Install = hs.loadSpoon("SpoonInstall")
-- Install.use_syncinstall = true

spoon.SpoonInstall.repos.zzspoons = {
  url = "https://github.com/zzamboni/zzSpoons",
  desc = "zzamboni's spoon repository",
}

-- Load Hammerspoon bits from https://github.com/jasonrudolph/ControlEscape.spoon
-- I need to figure out how to load this via SpoonInstall.
Install:andUse("ControlEscape", { start = true })

Install:andUse("Hammer", {
  repo = "zzspoons",
  -- config = {auto_reload_config = false},
  hotkeys = { config_reload = { hyper, "r" }, toggle_console = { hyper, "y" } },
  start = true,
})
-- -- Handy for debugging. From:
-- --    https://github.com/kikito/inspect.lua/blob/master/inspect.lua
-- --    https://world.hey.com/jonash/alacritty-drop-down-guake-quake-style-terminal-setup-on-macos-6eef7d73
-- -- luacheck: globals inspect
-- inspect = require("inspect")

-- hs.hotkey.bind({"ctrl", "alt"}, "space", function()
hs.hotkey.bind({ "alt" }, "return", function()
  local termID = "com.github.wez.wezterm"
  local app = hs.application.get("WezTerm")

  if app then
    if not app:mainWindow() then
      app:selectMenuItem({ "WezTerm", "New OS window" })
    elseif app:isFrontmost() then
      app:hide()
    else
      app:activate()
    end
  else
    app = hs.application.open(termID, 10, true)
    if not app then
      return
    end
  end

  app:mainWindow():moveToUnit("[99.9,50,0.1,0]")
end)

Install:andUse("FadeLogo", { config = { default_run = 1.0 }, start = true })

-- EOF
