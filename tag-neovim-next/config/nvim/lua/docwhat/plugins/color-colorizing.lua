-- Colorize color strings in buffer.
local M = { 'chrisbra/Colorizer' }

M.opts = {}
M.config = function() vim.cmd('ColorHighlight') end

return M
