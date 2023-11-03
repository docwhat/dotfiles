local M = {
  "williamboman/mason.nvim",
}

M.build = ":MasonUpdate"

M.config = function()
  require("mason").setup({
    ui = {
      border = "rounded",
      icons = {
        package_installed = "✔",
        package_pending = "➜",
        package_uninstalled = "",
      },
    },
    ensure_installed = {
      -- GoLang
      "gopls",

      -- Lua
      "lua_ls",

      -- Shell
      "bashls",
      "shfmt",
      "shellcheck",

      -- Vim
      "vimls",
      "vint",
    },
  })
end

return M
