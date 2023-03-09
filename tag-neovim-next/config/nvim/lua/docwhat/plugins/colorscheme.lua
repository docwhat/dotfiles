return {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.gruvbox_material_background = "hard"
		vim.g.gruvbox_material_visual = "blue background"
		vim.g.gruvbox_material_menu_selection_background = "blue"

		local term_prog = vim.env.TERM_PROGRAM
		if term_prog == "iTerm.app" or term_prog == "kitty" or term_prog == "WezTerm" then
			vim.g.gruvbox_material_enable_italic = 1
			vim.g.gruvbox_material_disable_italic_comment = 1
		end
		vim.cmd("colorscheme gruvbox-material")
	end,
}
