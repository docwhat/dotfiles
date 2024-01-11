local M = {
  "neovim/nvim-lspconfig",
}

M.dependencies = {
  "cmp-nvim-lsp",
  "onsails/lspkind-nvim",
  "lsp-zero.nvim",
  "neovim/nvim-lspconfig",
  "mason-lspconfig.nvim",
  "lspsaga.nvim",
}

M.servers = nil

---@diagnostic disable-next-line: unused-local
M.config = function(plugin)
  local lsp_zero = require("lsp-zero")
  lsp_zero.extend_lspconfig()

  ---@diagnostic disable-next-line: unused-local
  lsp_zero.on_attach(function(client, buffer)
    lsp_zero.default_keymaps({ buffer = buffer })
  end)

  require("docwhat.plugins.lspsaga").post_lspconfig_config()

  local server = require("docwhat.lsp-servers")
  local lsp = require("lspconfig")

  lsp.lua_ls.setup(server.lua_ls)
  -- lsp.rust_analyzer.setup(server.rust_analyzer)
  -- lsp.clangd.setup(server.clangd)
  -- lsp.gopls.setup(server.gopls)
  -- lsp.tsserver.setup(server.tsserver)
end

return M
