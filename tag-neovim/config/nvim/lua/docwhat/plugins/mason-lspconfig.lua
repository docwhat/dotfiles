local Plugin = {
  "mason-org/mason-lspconfig.nvim",
}

Plugin.dependencies = {
  { "mason.nvim", opts = {} },
  "nvim-lspconfig",
}

Plugin.opts = {}

return Plugin
