-- GitHub copilot.
-- Pure Lua version of "github/copilot.vim",
local M = {
  "zbirenbaum/copilot-cmp",
}

M.dependencies = {
  "zbirenbaum/copilot.lua",
}

M.config = function()
  require("copilot").setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
  })
  require("copilot_cmp").setup()
end

return M
