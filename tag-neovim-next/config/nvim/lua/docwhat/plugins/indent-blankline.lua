-- Description: Indentation guides for Neovim with 🌈rainbow🌈 colors
-- luacheck: globals vim
local M = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
}

M.opts = {
  -- https://en.wikipedia.org/wiki/Box-drawing_character is useful
  -- for finding characters to use.
  --
  -- char = "┆",
  -- context_char = "┇",
  -- show_current_context = true,
  -- char_highlight_list = {
  --   "IndentBlanklineIndent1",
  --   "IndentBlanklineIndent2",
  --   "IndentBlanklineIndent3",
  --   "IndentBlanklineIndent4",
  --   "IndentBlanklineIndent5",
  --   "IndentBlanklineIndent6",
  --   "IndentBlanklineIndent7",
  -- },
}

M.config = function(_, opts)
  require("ibl").setup(opts)

  -- vim.cmd([[highlight! link IndentBlanklineContextChar Normal]])
  --
  -- vim.cmd([[highlight! link IndentBlanklineIndent1 Red]])
  -- vim.cmd([[highlight! link IndentBlanklineIndent3 Orange]])
  -- vim.cmd([[highlight! link IndentBlanklineIndent2 Yellow]])
  -- vim.cmd([[highlight! link IndentBlanklineIndent4 Green]])
  -- vim.cmd([[highlight! link IndentBlanklineIndent5 Aqua]])
  -- vim.cmd([[highlight! link IndentBlanklineIndent6 Blue]])
  -- vim.cmd([[highlight! link IndentBlanklineIndent7 Purple]])
end

return M
