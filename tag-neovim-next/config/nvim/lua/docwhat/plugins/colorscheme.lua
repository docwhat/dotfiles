-- gruvbox material colorscheme

return {
  "sainnhe/gruvbox-material",
  lazy = true,
  priority = 1000,

  config = function()
    vim.g.gruvbox_material_background = "hard"

    local term_prog = vim.env.TERM_PROGRAM
    if term_prog == "iTerm.app" or term_prog == "kitty" or term_prog == "WezTerm" then
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_disable_italic_comment = 1
    end
  end,
}
