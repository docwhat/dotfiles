-- Description: Status line configuration
-- luacheck: globals vim

local M = {
  "nvim-lualine/lualine.nvim",
}

M.dependencies = {
  { "nvim-web-devicons" },
}

M.event = "VeryLazy"
M.opts = {}

return M
