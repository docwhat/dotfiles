-- Description: Status line configuration
-- luacheck: globals vim
return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = {},
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', opts = {} },
  },
}
