-- GitHub copilot.
-- Pure Lua version of "github/copilot.vim",
local M = {
  "zbirenbaum/copilot.lua",
}

M.config = function()
  require("copilot").setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
  })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuOpen",
  callback = function()
    vim.b.copilot_suggestion_hidden = true
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuClose",
  callback = function()
    vim.b.copilot_suggestion_hidden = false
  end,
})

return M
