-- Description: Language server configuration for Neovim
-- luacheck: globals vim
local missingGlobalVimFix = function()
  local lspZero = require("lsp-zero")
  -- Fix Undefined global 'vim'
  lspZero.configure("lua_ls", {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  })

  lspZero.configure("yamlls", {
    settings = {
      yaml = {
        keyOrdering = false,
      },
    },
  })
end

local setupLspZero = function()
  local lsp = require("lsp-zero")

  lsp.preset("recommended")

  lsp.ensure_installed({
    "lua_ls",
  })

  local cmp = require("cmp")
  local cmp_select = { behavior = cmp.SelectBehavior.Select }
  local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  })

  cmp_mappings["<Tab>"] = nil
  cmp_mappings["<S-Tab>"] = nil

  lsp.nvim_workspace()
  lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
  })

  -- LSP settings.
  --  This function gets run when an LSP connects to a particular buffer.
  lsp.on_attach(function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
      if desc then
        desc = "LSP: " .. desc
      end

      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    -- See `:help K` for why this keymap
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
      vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
  end)

  lsp.setup()

  vim.diagnostic.config({
    virtual_text = true,
  })
end

return {
  "VonHeikemen/lsp-zero.nvim",
  version = "v1.x",
  dependencies = {
    -- LSP Support
    { "neovim/nvim-lspconfig" }, -- Required
    {
      "williamboman/mason.nvim",
      opts = {
        ui = {
          border = "rounded",
        },
        ensure_installed = {
          "flake8",
          "shfmt",
          "stylua",
          "hadolint",
          "prettier",
        },
      },
      config = function(_, opts)
        require("mason").setup(opts)
        local mr = require("mason-registry")
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end,
    }, -- Optional
    { "williamboman/mason-lspconfig.nvim" }, -- Optional

    -- Autocompletion
    { "hrsh7th/nvim-cmp" }, -- Required
    { "hrsh7th/cmp-nvim-lsp" }, -- Required
    { "hrsh7th/cmp-buffer" }, -- Optional
    { "hrsh7th/cmp-path" }, -- Optional
    { "saadparwaiz1/cmp_luasnip" }, -- Optional
    { "hrsh7th/cmp-nvim-lua" }, -- Optional

    -- Snippets
    { "L3MON4D3/LuaSnip" }, -- Required
    { "rafamadriz/friendly-snippets" }, -- Optional

    -- Additional
    { "folke/neodev.nvim" },
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    missingGlobalVimFix()
    setupLspZero()
  end,
}
