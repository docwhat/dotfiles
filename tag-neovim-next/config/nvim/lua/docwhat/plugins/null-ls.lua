return {
	"jose-elias-alvarez/null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "mason.nvim" },
	opts = function()
		local nls = require("null-ls")
		return {
			sources = {
				nls.builtins.formatting.fish_indent,
				nls.builtins.diagnostics.fish,
				nls.builtins.formatting.stylua,
				nls.builtins.formatting.shfmt,
				nls.builtins.diagnostics.flake8,
			},
		}
	end,
}
