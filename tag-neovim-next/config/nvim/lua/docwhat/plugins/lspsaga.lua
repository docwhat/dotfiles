local M = {
  "nvimdev/lspsaga.nvim",
}

M.event = { "BufReadPost", "BufNewFile" }

M.dependencies = {
  "nvim-treesitter",
  "nvim-web-devicons",
}

M.post_lspconfig_config = function()
  require("lspsaga").setup({
    defintion = {
      height = 0.5,
      width = 0.6,
      keys = {
        edit = "l",
        vsplit = "v",
        split = "b",
        tabe = "t",
        quit = { "q", "<ESC>" },
        close = "x",
      },
    },
    outline = {
      win_position = "right",
      win_width = 30,
      auto_preview = true,
      detail = true,
      auto_close = true,
      close_after_jump = false,
      layout = "normal",
      max_height = 0.5,
      left_width = 0.3,
      keys = {
        toggle_or_jump = "l",
        quit = { "q", "<ESC>", "h" },
        jump = "o",
      },
    },
    ui = {
      border = "rounded",
      devicon = true,
      title = true,
      expand = "⊟",
      code_action = "",
      actionfix = " ",
      lines = { "╰", "├", "│", "─", "╭" },
      kind = {},
      imp_sign = "󰳛",
    },
    symbol_in_winbar = {
      enable = true,
      separator = "  ",
      show_file = true,
      folded_level = 1,
      color_mode = true,
      delay = 1,
    },
    code_action = {
      num_shortcut = 2,
      show_server_name = false,
      extend_gitsigns = false,
      keys = {
        quit = { "q", "<ESC>" },
        exec = "<CR>",
      },
    },
    rename = {
      in_select = true,
      auto_save = false,
      project_max_width = 0.5,
      project_max_height = 0.5,
      keys = {
        quit = { "q", "<ESC>" },
        exec = "<CR>",
        select = "x",
      },
    },
    finder = {
      max_height = 0.6,
      max_width = 0.6,
      right_width = 0.3,
      default = "ref+imp",
      methods = {},
      layout = "float",
      filter = {},
      silent = false,
      keys = {
        vsplit = "v",
        split = "b",
        shuttle = "w",
        toggle_or_open = "l",
        quit = "q",
        close = "x",
        tabe = "t",
        tabnew = "T",
      },
    },
    diagnostic = {
      show_code_action = true,
      jump_num_shortcut = true,
      max_width = 0.6,
      max_height = 0.6,
      text_hl_follow = true,
      border_follow = true,
      extend_relatedInformation = false,
      show_layout = "float",
      show_normal_height = 10,
      max_show_width = 0.9,
      max_show_height = 0.6,
      diagnostic_only_current = true,
      keys = {
        quit = { "q", "<ESC>" },
        exec_action = "o",
        toggle_or_jump = "<CR>",
        quit_in_show = { "q", "<ESC>" },
      },
    },
  })
  local signs = {
    Error = "",
    Warn = "",
    Info = "",
    Hint = "󰠠",
    Question = "",
  }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  vim.diagnostic.config({
    signs = true,
    -- underline = false,
    update_in_insert = false,
    virtual_lines = false,
    severity_sort = true,
    -- No virtual text (distracting!), show popup window on hover.
    -- virtual_text = { spacing = 4, prefix = "●" },
    virtual_text = false,
    -- virtual_text = {
    --   severity = { min = vim.diagnostic.severity.WARN },
    -- source = true,
    --   prefix = vim.fn.has("nvim-0.10") > 0 and function(diagnostic) ---@param diagnostic Diagnostic
    --     return (icons[diagnostic.severity] or "") .. " "
    --   end,
    -- },
    underline = true,
    -- underline = {
    --   -- Do not underline text when severity is low (INFO or HINT).
    --   -- severity = { min = vim.diagnostic.severity.WARN },
    -- },
    float = {
      source = "always",
      focusable = true,
      focus = false,
      border = "rounded",

      -- Customize how diagnostic message will be shown: show error code.
      format = function(diagnostic)
        -- See null-ls.nvim#632, neovim#17222 for how to pick up `code`
        local user_data
        user_data = diagnostic.user_data or {}
        user_data = user_data.lsp or user_data.null_ls or user_data
        local code = (
                    -- TODO: symbol is specific to pylint (will be removed)
diagnostic.symbol
          or diagnostic.code
          or user_data.symbol
          or user_data.code
        )
        if code then
          return string.format("%s (%s)", diagnostic.message, code)
        else
          return diagnostic.message
        end
      end,
    },
  })
  local map = vim.api.nvim_set_keymap

  map("n", "<leader>ia", ":Lspsaga code_action<cr>", { desc = "Code Action", silent = true })
  map("n", "<leader>if", ":Lspsaga finder<cr>", { desc = "Finder", silent = true })
  map("n", "<leader>ir", ":Lspsaga rename<cr>", { desc = "Rename", silent = true })
  map("n", "<leader>io", ":Lspsaga outline<cr>", { desc = "Outline", silent = true })
  map("n", "<leader>ip", ":Lspsaga peek_definition<cr>", { desc = "Peek Definition", silent = true })
  map("n", "<leader>it", ":Lspsaga peek_type_definition<cr>", { desc = "Peek Type Definition", silent = true })
  map("n", "<leader>ig", ":Lspsaga goto_type_definition<cr>", { desc = "Goto Type Definition", silent = true })
  map("n", "K", ":Lspsaga hover_doc<cr>", { desc = "Hover Doc", silent = true })
  map("n", "]d", ":Lspsaga diagnostic_jump_next<cr>", { desc = "Next Diagnostic", silent = true })
  map("n", "[d", ":Lspsaga diagnostic_jump_prev<cr>", { desc = "Previous Diagnostic", silent = true })

  -- map("n", "<leader>id", function()
  --   return vim.diagnostic.open_float
  -- end, { desc = "Line Diagnostics" })
  map("n", "<leader>il", ":LspInfo<cr>", { desc = "Lsp Info", silent = true })
end

return M
