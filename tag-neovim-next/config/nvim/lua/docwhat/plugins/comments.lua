-- Description: Plugins to add, remove and update comments
-- luacheck: globals vim
return {
  {
    "echasnovski/mini.comment",
    version = "*",
    event = "VeryLazy",
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
    dependencies = {
      { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
    },
  },
}
