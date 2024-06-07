-- Description: Plugins to add, remove and update comments
-- luacheck: globals vim
local M = {
  "echasnovski/mini.comment",
}

M.version = "*"
M.event = "VeryLazy"
M.dependencies = {
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
}

M.opts = {
  hooks = {
    pre = function()
      require("ts_context_commentstring.internal").update_commentstring({})
    end,
  },
}

M.config = function(_, opts)
  require("mini.comment").setup(opts)
end

return M
