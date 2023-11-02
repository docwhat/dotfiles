local servers = {
  gopls = {
    cmd = { "gopls" },
    settings = {
      gopls = {
        experimentalPostfixCompletions = true,
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
        hints = {
          rassignVariableTypes = true,
          compositeLiteralFields = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
    init_options = {
      usePlaceholders = true,
    },
  },
  clangd = {},
  lua_ls = {
    -- enabled = false,
    -- cmd = { "/home/folke/projects/lua-language-server/bin/lua-language-server" },
    -- cmd = { 'lua-language-server' },
    single_file_support = true,
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            -- "${3rd}/luv/library"
            -- "${3rd}/busted/library",
          },
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
          -- library = vim.api.nvim_get_runtime_file("", true)
        },
        completion = {
          workspaceWord = true,
          callSnippet = "Both",
          -- callSnippet = "Replace",
        },
        misc = {
          parameters = {
            -- "--log-level=trace",
          },
        },
        hint = {
          enable = true,
          setType = false,
          paramType = true,
          paramName = "Disable",
          semicolon = "Disable",
          arrayIndex = "Disable",
        },
        doc = {
          privateName = { "^_" },
        },
        type = {
          castNumberToInteger = true,
        },
        diagnostics = {
          globals = { "vim" },
          -- disable = { "incomplete-signature-doc", "trailing-space" },
          -- -- enable = false,
          -- groupSeverity = {
          --   strong = "Warning",
          --   strict = "Warning",
          -- },
          -- groupFileStatus = {
          --   ["ambiguity"] = "Opened",
          --   ["await"] = "Opened",
          --   ["codestyle"] = "None",
          --   ["duplicate"] = "Opened",
          --   ["global"] = "Opened",
          --   ["luadoc"] = "Opened",
          --   ["redefined"] = "Opened",
          --   ["strict"] = "Opened",
          --   ["strong"] = "Opened",
          --   ["type-check"] = "Opened",
          --   ["unbalanced"] = "Opened",
          --   ["unused"] = "Opened",
          -- },
          -- unusedLocalExclude = { "_*" },
        },
        format = {
          enable = true,
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
            continuation_indent_size = "2",
          },
        },
      },
    },
  },
  -- codelldb = {},
  -- bashls = {},
  -- cssls = {},
  tsserver = {
    -- settings = {
    --   javascript = {
    --     inlayHints = {
    --       includeInlayEnumMemberValueHints = true,
    --       includeInlayFunctionLikeReturnTypeHints = true,
    --       includeInlayFunctionParameterTypeHints = true,
    --       includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
    --       includeInlayParameterNameHintsWhenArgumentMatchesName = true,
    --       includeInlayPropertyDeclarationTypeHints = true,
    --       includeInlayVariableTypeHints = true,
    --     },
    --   },
    --   typescript = {
    --     inlayHints = {
    --       includeInlayEnumMemberValueHints = true,
    --       includeInlayFunctionLikeReturnTypeHints = true,
    --       includeInlayFunctionParameterTypeHints = true,
    --       includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
    --       includeInlayParameterNameHintsWhenArgumentMatchesName = true,
    --       includeInlayPropertyDeclarationTypeHints = true,
    --       includeInlayVariableTypeHints = true,
    --     },
    --   },
    -- },
  },
  html = {},
  -- jsonls = {},
  -- pyright = {},
  -- yamlls = {},
  -- remark_ls = {},
  rust_analyzer = { -- rustup component add rust-analyzer
    cmd = { "rustup", "run", "stable", "rust-analyzer" },
  },
  -- sumneko_lua = {
  --   settings = {
  --     Lua = {
  --       workspace = {
  --         checkThirdParty = false,
  --       },
  --       hint = {
  --         enable = false,
  --       },
  --     },
  --   },
  -- },
}

return servers
