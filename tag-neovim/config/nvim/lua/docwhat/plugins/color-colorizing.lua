-- Description: Colorize color strings in buffer.
-- luacheck: globals vim
local M = { "chrisbra/Colorizer" }

M.opts = {}
M.config = function()
  vim.cmd("ColorHighlight")
end

return M
