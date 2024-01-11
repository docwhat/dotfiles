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
    single_file_support = true,
    settings = {
      Lua = {
        -- Make the server aware of Neovim runtime files
        runtime = {
          version = "LuaJIT",
          path = vim.split(package.path, ";"),
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          maxPreload = 10000,
          preloadFileSize = 10000,
        },
        completion = {
          callSnippet = "Replace",
        },
        diagnostics = {
          enable = true,
          globals = { "vim", "use" },
        },
        format = {
          enable = true,
        },
        telemetry = { enable = false },
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
}

servers.sumneko_lua = servers.lua_ls
--   settings = {
--     Lua = {
--       runtime = {
--         version = "LuaJIT",
--         path = vim.split(package.path, ";"),
--       },
--       completion = {
--         callSnippet = "Replace",
--       },
--       diagnostics = {
--         enable = true,
--         globals = { "vim", "use" },
--       },
--       workspace = {
--         library = vim.api.nvim_get_runtime_file("", true),
--         maxPreload = 10000,
--         preloadFileSize = 10000,
--       },
--       telemetry = { enable = false },
--       -- workspace = {
--       --   checkThirdParty = false,
--       -- },
--       -- hint = {
--       --   enable = false,
--       -- },
--     },
--   },
-- },

return servers
