local M = {
  "nvimdev/lspsaga.nvim",
}

M.event = { "LspAttach" }

M.dependencies = {
  "nvim-treesitter",
  "nvim-web-devicons",
}

M.config = function()
  local c = {}

  -- https://nvimdev.github.io/lspsaga/breadcrumbs/
  c.symbol_in_winbar = { enable = true }

  -- https://nvimdev.github.io/lspsaga/callhierarchy/
  c.callhierarchy = {}

  -- https://nvimdev.github.io/lspsaga/codeaction/
  c.code_action = {
    keys = {
      quit = { "q", "<ESC>" },
    },
  }

  -- https://nvimdev.github.io/lspsaga/definition/
  c.definition = {
    keys = {
      quit = { "q", "<ESC>" },
    },
  }

  -- https://nvimdev.github.io/lspsaga/diagnostic/
  c.diagnostic = {
    diagnostic_only_current = true,
    keys = {
      quit = { "q", "<ESC>" },
      quit_in_show = { "q", "<ESC>" },
    },
  }

  -- https://nvimdev.github.io/lspsaga/finder/
  c.finder = {
    keys = {
      quit = { "q", "<ESC>" },
    },
  }

  -- https://nvimdev.github.io/lspsaga/outline/
  c.outline = {
    keys = {
      quit = { "q", "<ESC>" },
    },
  }

  require("lspsaga").setup(c)

  -- Turn off diagnostic virtual text in favor of Lspsaga
  vim.diagnostic.config({
    virtual_text = false,
  })
end

-- nmap - Nvim normal mode keymap
local function nmap(keys, command, description)
  vim.keymap.set("n", keys, command, { desc = description, silent = true })
end

nmap("<leader>io", "<cmd>Lspsaga outline<cr>", "[O]utline")
nmap("<leader>ia", "<cmd>Lspsaga code_action<cr>", "Code [A]ction")
--
nmap("<leader>if", "<cmd>Lspsaga finder<cr>", "[F]inder")
nmap("<leader>ir", "<cmd>Lspsaga rename<cr>", "[R]ename")
nmap("<leader>ip", "<cmd>Lspsaga peek_definition<cr>", "[P]eek Definition")
nmap("<leader>it", "<cmd>Lspsaga peek_type_definition<cr>", "Peek [T]ype Definition")
nmap("<leader>ig", "<cmd>Lspsaga goto_type_definition<cr>", "[G]oto Type Definition")

nmap("K", "<cmd>Lspsaga hover_doc<cr>", "Hover Doc")

nmap("tt", "<cmd>Lspsaga term_toggle<cr>", "[T]erm Toggle(C- C-O t to close)")

nmap("]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", "Next [D]iagnostic")
nmap("[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Previous [D]iagnostic")
nmap("<leader>id", vim.diagnostic.open_float, "Line [D]iagnostics")

nmap("<leader>il", "<cmd>LspInfo<cr>", "[L]sp Info")

return M
