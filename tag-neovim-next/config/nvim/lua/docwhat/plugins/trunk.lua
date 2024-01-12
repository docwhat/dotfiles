-- Integrate the Trunk.io super linter.
-- https://docs.trunk.io/check/reference/neovim-plugin

local Plugin = {
  "trunk-io/neovim-trunk",
  main = "trunk",
}

Plugin.dependencies = {
  "telescope.nvim",
  "plenary.nvim",
}

return Plugin
