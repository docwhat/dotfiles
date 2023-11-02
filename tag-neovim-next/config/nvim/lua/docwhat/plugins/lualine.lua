-- Description: Status line configuration
-- luacheck: globals vim

local M = {
  "nvim-lualine/lualine.nvim",
}

M.dependencies = {
  { "nvim-tree/nvim-web-devicons", opts = {} },
}

M.event = "VeryLazy"
M.opts = {}

return M
