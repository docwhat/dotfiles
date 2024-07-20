local M = {
  "neovim/nvim-lspconfig",
}

M.dependencies = {
  "mason-lspconfig.nvim",
  "nlsp-settings.nvim",
}

M.lazy = true

M.config = function()
  -- This is where all the LSP shenanigans will live
  local lsp_zero = require("lsp-zero")
  lsp_zero.extend_lspconfig()

  ---@diagnostic disable-next-line: unused-local
  lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
  end)
end

return M
