-- https://github.com/folke/which-key.nvim#readme
-- Displays a popup with possible key bindings of the command you started typing.
local M = {
  "folke/which-key.nvim",
}

M.event = "VeryLazy"
M.init = function()
  vim.o.timeout = true
  vim.o.timeoutlen = 300
end

M.opts = {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

return M
