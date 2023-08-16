-- Description: Null-ls configuration
-- luacheck: globals vim
--
return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = {
    {
      "jay-babu/mason-null-ls.nvim",
      dependencies = {
        "mason.nvim",
      },
      "plenary.nvim",
      "lewis6991/gitsigns.nvim",
      "ThePrimeagen/refactoring.nvim",
    },
  },

  opts = {
    automatic_setup = true,
    automatic_installation = false,
    ensure_installed = {},
    handlers = {},
  },

  config = function(_, opts)
    require("mason").setup()
    require("mason-null-ls").setup(opts)
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.hover.dictionary,
      },
    })
  end,
}
