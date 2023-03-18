-- Description: Graphical representation of the Neovim undo tree
-- luacheck: globals vim
return {
  "mbbill/undotree",
  version = "rel_*",
  keys = {
    { "<leader>u", vim.cmd.UndotreeToggle, desc = "[U]ndotree Toggle" },
  },
}
