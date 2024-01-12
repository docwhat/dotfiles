local Plugin = {
  "williamboman/mason.nvim",
}

Plugin.build = ":MasonUpdate"

-- See lsp-zero.lua for configuration.
Plugin.config = function() end

return Plugin
