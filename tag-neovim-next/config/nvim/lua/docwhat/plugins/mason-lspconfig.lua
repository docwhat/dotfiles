local M = {
  "williamboman/mason-lspconfig.nvim",
}

M.dependencies = {
  "mason.nvim",
  "lsp-zero.nvim",
}

M.config = function()
  local lsp_zero = require("lsp-zero")
  lsp_zero.extend_lspconfig()

  require("mason-lspconfig").setup({
    automatic_installation = true,
    handlers = { lsp_zero.default_setup },
  })
end

return M
