-- Description: Plugins to add, remove and update comments
-- luacheck: globals vim
local Plugin = {
  "echasnovski/mini.comment",
}

Plugin.version = "*"
-- Plugin.event = "VeryLazy"
Plugin.dependencies = {
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
}

Plugin.opts = {
  mappings = {
    comment = "",
  },
  hooks = {
    pre = function()
      require("ts_context_commentstring.internal").update_commentstring({})
    end,
  },
}

Plugin.config = function(_, opts)
  require("mini.comment").setup(opts)
end

return Plugin
