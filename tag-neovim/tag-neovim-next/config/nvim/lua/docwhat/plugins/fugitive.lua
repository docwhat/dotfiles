-- Description: Git integration
-- luacheck: globals vim
return {
  "tpope/vim-fugitive",
  keys = {
    { "<leader>gs", vim.cmd.Git, desc = "[G]it [S]tatus" },
  },
}
