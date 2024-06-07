-- GitHub copilot.
-- Pure Lua version of "github/copilot.vim",
local M = {
  "zbirenbaum/copilot-cmp",
}

M.dependencies = {
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}

M.config = function()
  local lsp_zero = require("lsp-zero")
  lsp_zero.extend_lspconfig()

  require("copilot").setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
  })
end

return M
