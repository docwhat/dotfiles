-- Integrate the Trunk.io super linter.
-- https://docs.trunk.io/check/reference/neovim-plugin

local M = {
  "trunk-io/neovim-trunk",
  lazy = false,
  main = "trunk",
}

-- Needed to force running of setup()
M.config = function()
  local lsp_zero = require("lsp-zero")
  lsp_zero.extend_lspconfig()

  require("trunk").setup({
    automatic_installation = true,
    handlers = { lsp_zero.default_setup },
  })
end

M.dependencies = {
  "nvim-telescope/telescope.nvim",
  "nvim-lua/plenary.nvim",
}

return M
