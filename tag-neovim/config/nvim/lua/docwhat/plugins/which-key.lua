-- https://github.com/folke/which-key.nvim#readme
-- Displays a popup with possible key bindings of the command you started typing.
local Plugin = {
  "folke/which-key.nvim",
}

Plugin.event = "VeryLazy"
Plugin.init = function()
  -- vim.o.timeout = true
  -- vim.o.timeoutlen = 300
end

Plugin.opts = {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

return Plugin
