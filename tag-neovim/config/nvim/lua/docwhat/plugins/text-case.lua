-- Description: Text Case utilities
-- luacheck: globals vim

local Plugin = {
  "johmsalas/text-case.nvim"
}

Plugin.dependencies = { "telescope.nvim" }

Plugin.config = function()
  require("textcase").setup({})
  require("telescope").load_extension("textcase")
end

Plugin.keys = {
  "ga", -- Default invocation prefix
  { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
}

Plugin.cmd = {
  -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
  "Subs",
  "TextCaseOpenTelescope",
  "TextCaseOpenTelescopeQuickChange",
  "TextCaseOpenTelescopeLSPChange",
  "TextCaseStartReplacingCommand",
}

-- If you want to use the interactive feature of the `Subs` command right away, text-case.nvim
-- has to be loaded on startup. Otherwise, the interactive feature of the `Subs` will only be
-- available after the first executing of it or after a keymap of text-case.nvim has been used.
Plugin.lazy = false

return Plugin
