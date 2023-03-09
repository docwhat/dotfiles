local function telescope(builtin, opts)
	local args = { builtin = builtin, opts = opts }
	return function()
		require("telescope.builtin")[args.builtin](args.opts)
	end
end

return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	version = "*",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		defaults = {
			prompt_prefix = " ",
			selection_caret = " ",
			mappings = {
				i = {
					["<c-t>"] = function(...)
						return require("trouble.providers.telescope").open_with_trouble(...)
					end,
					["<a-t>"] = function(...)
						return require("trouble.providers.telescope").open_selected_with_trouble(...)
					end,
					["<a-i>"] = function()
						telescope("find_files", { no_ignore = true })()
					end,
					["<a-h>"] = function()
						telescope("find_files", { hidden = true })()
					end,
					["<C-Down>"] = function(...)
						return require("telescope.actions").cycle_history_next(...)
					end,
					["<C-Up>"] = function(...)
						return require("telescope.actions").cycle_history_prev(...)
					end,
					["<C-f>"] = function(...)
						return require("telescope.actions").preview_scrolling_down(...)
					end,
					["<C-b>"] = function(...)
						return require("telescope.actions").preview_scrolling_up(...)
					end,
				},
				n = {
					["q"] = function(...)
						return require("telescope.actions").close(...)
					end,
				},
			},
		},
	},
	keys = {
		{ "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
		{ "<leader>/", telescope("live_grep"), desc = "Find in Files (Grep)" },
		{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
		{ "<leader><space>", telescope("find_files"), desc = "Find Files (root dir)" },
		-- find
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "[F]ind [B]uffers" },
		{ "<leader>ff", telescope("find_files"), desc = "[F]ind [F]iles (root dir)" },
		{ "<leader>sf", telescope("find_files"), desc = "[S]earch [F]iles" },
		{ "<leader>fF", telescope("find_files", { cwd = false }), desc = "[F]ind [F]iles (cwd)" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "[F] [R]ecent Files" },
		-- git
		{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "[G]it [C]ommits" },
		{ "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "[G]it [S]tatus" },
		-- search
		{ "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "[S]earch [A]uto Commands" },
		{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "[S]earch [B]uffer" },
		{ "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "[S]earch [C]ommand History" },
		{ "<leader>sC", "<cmd>Telescope commands<cr>", desc = "[S]earch [C]ommands" },
		{ "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "[S]earch [D]iagnostics" },
		{ "<leader>sg", telescope("live_grep"), desc = "[S]earch [G]rep (root dir)" },
		{ "<leader>sG", telescope("live_grep", { cwd = false }), desc = "[S]earch [G]rep (cwd)" },
		{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "[S]earch [H]elp Pages" },
		{
			"<leader>sH",
			"<cmd>Telescope highlights<cr>",
			desc = "[S]earch [H]ighlight Groups",
		},
		{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "[S]earch [K]ey Maps" },
		{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "[S]earch [M]an Pages" },
		{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to [M]ark" },
		{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "[S]earch [O]ptions" },
		{ "<leader>sR", "<cmd>Telescope resume<cr>", desc = "[S]earch [R]esume" },
		{ "<leader>sw", telescope("grep_string"), desc = "[S]earch [W]ord (root dir)" },
		{ "<leader>sW", telescope("grep_string", { cwd = false }), desc = "[S]earch [W]ord (cwd)" },
		{ "<leader>uC", telescope("colorscheme", { enable_preview = true }), desc = "[C]olorscheme with preview" },
		{
			"<leader>ss",
			telescope("lsp_document_symbols", {
				symbols = {
					"Class",
					"Function",
					"Method",
					"Constructor",
					"Interface",
					"Module",
					"Struct",
					"Trait",
					"Field",
					"Property",
				},
			}),
			desc = "Goto [S]ymbol",
		},
				{
					"<leader>sS",
					telescope("lsp_workspace_symbols", {
						symbols = {
							"Class",
							"Function",
							"Method",
							"Constructor",
							"Interface",
							"Module",
							"Struct",
							"Trait",
							"Field",
							"Property",
						},
					}),
					desc = "Goto [S]ymbol (Workspace)",
				},
	},
}
