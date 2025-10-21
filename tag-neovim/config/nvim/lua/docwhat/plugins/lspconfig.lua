local Plugin = {
  "neovim/nvim-lspconfig",
}

Plugin.dependencies = {
  "mason-lspconfig.nvim",
  "nlsp-settings.nvim",
}

Plugin.lazy = true

return Plugin
