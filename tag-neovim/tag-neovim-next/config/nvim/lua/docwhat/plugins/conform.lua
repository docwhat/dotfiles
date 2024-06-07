local Plugin = {
  "stevearc/conform.nvim",
}

Plugin.event = { "BufWritePre" }
Plugin.cmd = { "ConformInfo" }

Plugin.keys = {
  {
    -- Customize or remove this keymap to your liking
    "<leader>f",
    function()
      require("conform").format({ async = true, lsp_fallback = true })
    end,
    mode = "n",
    desc = "[F]ormat entire buffer (conform)",
  },
  {
    -- Customize or remove this keymap to your liking
    "<leader>f",
    function()
      require("conform").format({ async = true, lsp_fallback = true })
    end,
    mode = "x",
    desc = "[F]ormat selection (conform)",
  },
}

-- Everything in opts will be passed to setup()
Plugin.opts = {
  -- Define your formatters
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { { "prettierd", "prettier" } },
  },
  -- Set up format-on-save
  format_on_save = { timeout_ms = 500, lsp_fallback = true },
  -- Customize formatters
  formatters = {
    -- shfmt = {
    --   prepend_args = { "-i", "2" },
    -- },
  },
}

Plugin.init = function()
  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end

return Plugin
