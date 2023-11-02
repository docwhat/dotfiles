local M = {}
M.mason_lspconfig = function()
  local lsp_zero = require("lsp-zero")
  lsp_zero.extend_lspconfig()

  require("mason-lspconfig").setup({
    automatic_installation = true,
    handlers = { lsp_zero.default_setup },
    ensure_installed = {
      "gopls",
      "lua_ls",
    },
  })
end

M.build = ":MasonUpdate"

M.config = function()
  require("mason").setup({
    ui = {
      border = "rounded",
      icons = {
        package_installed = "✔",
        package_pending = "➜",
        package_uninstalled = "",
      },
    },
  })
end

return M
