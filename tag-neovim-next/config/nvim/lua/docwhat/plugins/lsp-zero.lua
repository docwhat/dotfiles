-- Collection of functions that will help you setup Neovim's LSP client, so
-- you can get IDE-like features with minimum effort.
-- https://github.com/VonHeikemen/lsp-zero.nvim/tree/v3.x

local Plugin = { "VonHeikemen/lsp-zero.nvim" }

Plugin.branch = "v3.x"

Plugin.dependencies = {
  "mason.nvim",
  "mason-lspconfig.nvim",
  "nvim-lspconfig",
  "cmp-nvim-lsp",
  "nvim-cmp",
  "LuaSnip",
}

Plugin.config = function()
  local lsp_zero = require("lsp-zero")

  -- nvim-cmp supports additional completion capabilities, so broadcast
  -- that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  -- Require Mason LSP package manager
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

  require("mason-lspconfig").setup({
    ensure_installed = {
      "gopls", -- GoLang
      "lua_ls", -- Lua
      "bashls", -- Shell
    },

    handlers = {
      lsp_zero.default_setup,
    },
  })

  require("trunk").setup({})
end

return Plugin
