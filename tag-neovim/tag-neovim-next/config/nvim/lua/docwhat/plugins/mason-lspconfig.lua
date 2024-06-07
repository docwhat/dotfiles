local Plugin = {
  "williamboman/mason-lspconfig.nvim",
}

Plugin.dependencies = {
  "mason.nvim",
}

Plugin.lazy = true
Plugin.event = "User FileOpened"

Plugin.cmd = { "LspInstall", "LspUninstall" }

Plugin.config = function() end
-- See lsp-zero.lua for configuration.

return Plugin
