-- Description: Popup search and selection dialogs
-- luacheck: globals vim
local function builtin(builtin_name, opts)
  local args = { builtin = builtin_name, opts = opts }
  return function()
    require("telescope.builtin")[args.builtin](args.opts)
  end
end

local function is_available_in_lazy(plugin)
  local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
  return lazy_config_avail and lazy_config.plugins[plugin] ~= nil
end

local M = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  branch = "master",
}

M.dependencies = {
  "plenary.nvim",
  "nvim-web-devicons",
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    enabled = vim.fn.executable("make") == 1,
    build = "make",
  },
  "tsakirist/telescope-lazy.nvim",
}

M.config = function(_, opts)
  local telescope = require("telescope")
  telescope.setup(opts)

  if pcall(require, "notify") then
    telescope.load_extension("notify")
  end

  if is_available_in_lazy("telescope-fzf-native.nvim") then
    telescope.load_extension("fzf")
  end

  if is_available_in_lazy("telescope-lazy.nvim") then
    telescope.load_extension("lazy")
  end
end

M.opts = {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    show_icon = true,
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--context=0",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    mappings = {
      i = {
        ["<c-t>"] = function(...)
          return require("trouble.providers.telescope").open_with_trouble(...)
        end,
        ["<a-t>"] = function(...)
          return require("trouble.providers.telescope").open_selected_with_trouble(...)
        end,
        ["<a-i>"] = function()
          builtin("find_files", { no_ignore = true })()
        end,
        ["<a-h>"] = function()
          builtin("find_files", { hidden = true })()
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
}

M.keys = {
  { "<leader>,",       builtin("buffers", { show_all_buffers = true }),   desc = "Switch Buffer" },
  { "<leader>/",       builtin("live_grep"),                              desc = "Find in Files (Grep)" },
  { "<leader>:",       builtin("command_history"),                        desc = "Command History" },
  { "<leader><space>", builtin("find_files"),                             desc = "Find Files (root dir)" },
  -- find
  { "<leader>fb",      builtin("buffers"),                                desc = "[F]ind [B]uffers" },
  { "<leader>ff",      builtin("find_files"),                             desc = "[F]ind [F]iles (root dir)" },
  { "<leader>sf",      builtin("find_files"),                             desc = "[S]earch [F]iles" },
  { "<leader>fF",      builtin("find_files", { cwd = false }),            desc = "[F]ind [F]iles (cwd)" },
  { "<leader>fr",      builtin("oldfiles"),                               desc = "[F] [R]ecent Files" },
  -- git
  { "<leader>gc",      builtin("git_commits"),                            desc = "[G]it [C]ommits" },
  { "<leader>gs",      builtin("git_status"),                             desc = "[G]it [S]tatus" },
  -- LSP
  { "<leader>iR",      builtin("lsp_references"),                         desc = "[R]eferences" },
  { "<leader>is",      builtin("lsp_document_symbols"),                   desc = "[S]ymbols" },
  { "<leader>iw",      builtin("lsp_workspace_symbols"),                  desc = "[W]orkspace-wide Symbols" },
  -- search
  { "<leader>sa",      builtin("autocommands"),                           desc = "[S]earch [A]uto Commands" },
  { "<leader>sb",      builtin("current_buffer_fuzzy_find"),              desc = "[S]earch [B]uffer" },
  { "<leader>sc",      builtin("command_history"),                        desc = "[S]earch [C]ommand History" },
  { "<leader>sC",      builtin("commands"),                               desc = "[S]earch [C]ommands" },
  { "<leader>sd",      builtin("diagnostics"),                            desc = "[S]earch [D]iagnostics" },
  { "<leader>sg",      builtin("live_grep"),                              desc = "[S]earch [G]rep (root dir)" },
  { "<leader>sG",      builtin("live_grep", { cwd = false }),             desc = "[S]earch [G]rep (cwd)" },
  { "<leader>sh",      builtin("help_tags"),                              desc = "[S]earch [H]elp Pages" },
  { "<leader>sH",      builtin("highlights"),                             desc = "[S]earch [H]ighlight Groups" },
  { "<leader>sk",      builtin("keymaps"),                                desc = "[S]earch [K]ey Maps" },
  { "<leader>sM",      builtin("man_pages"),                              desc = "[S]earch [M]an Pages" },
  { "<leader>sm",      builtin("marks"),                                  desc = "Jump to [M]ark" },
  { "<leader>so",      builtin("vim_options"),                            desc = "[S]earch [O]ptions" },
  { "<leader>sR",      builtin("resume"),                                 desc = "[S]earch [R]esume" },
  { "<leader>sw",      builtin("grep_string"),                            desc = "[S]earch [W]ord (root dir)" },
  { "<leader>sW",      builtin("grep_string", { cwd = false }),           desc = "[S]earch [W]ord (cwd)" },
  { "<leader>uC",      builtin("colorscheme", { enable_preview = true }), desc = "[C]olorscheme with preview" },
  {
    "<leader>ss",
    builtin("lsp_document_symbols", {
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
    builtin("lsp_workspace_symbols", {
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
}

return M
