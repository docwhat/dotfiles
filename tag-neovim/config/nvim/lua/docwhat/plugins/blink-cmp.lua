-- Completion plugin

local Plugin = {
  'saghen/blink.cmp'
}


Plugin.dependencies = {
  -- optional: provides snippets for the snippet source
  'rafamadriz/friendly-snippets',

  -- Purty LSP menus
  'lspkind.nvim',

  -- Purty icons.
  'nvim-web-devicons',

  -- Emojis
  "moyiz/blink-emoji.nvim",

  -- Connects copilot.lua to Blink.cmp
  "giuxtaposition/blink-cmp-copilot",
}

-- use a release tag to download pre-built binaries
Plugin.version = '1.*'

-- Copied from version
-- local default_kind_icons = require("blink-cmp.opts.appearance.kind_icons")

---@module 'blink.cmp'
---@type 'blink.cmp'.ConfigStrict

Plugin.opts = {
  -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
  -- 'super-tab' for mappings similar to vscode (tab to accept)
  -- 'enter' for enter to accept
  -- 'none' for no mappings
  --
  -- All presets have the following mappings:
  -- C-space: Open menu or open docs if already open
  -- C-n/C-p or Up/Down: Select next/previous item
  -- C-e: Hide menu
  -- C-k: Toggle signature help (if signature.enabled = true)
  --
  -- See :h blink-cmp-config-keymap for defining your own keymap
  keymap = { preset = 'super-tab' },

  -- (Default) Only show the documentation popup when manually triggered
  completion = {
    menu = {
      draw = {
        components = {
          kind_icon = {
            text = function(ctx)
              local icon = ctx.kind_icon
              if vim.tbl_contains({ "Copilot" }, ctx.source_name) then
                icon = ""
              elseif vim.tbl_contains({ "Path" }, ctx.source_name) then
                local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then
                  icon = dev_icon
                end
              else
                icon = require("lspkind").symbolic(ctx.kind, {
                  mode = "symbol",
                })
              end

              return icon .. ctx.icon_gap
            end,

            -- Optionally, use the highlight groups from nvim-web-devicons
            -- You can also add the same function for `kind.highlight` if you want to
            -- keep the highlight groups in sync with the icons.
            highlight = function(ctx)
              local hl = ctx.kind_hl
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then
                  hl = dev_hl
                end
              end
              return hl
            end,
          }
        }
      }
    }
  },

  -- Default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`
  sources = {
    default = {
      'lsp',
      'path',
      'snippets',
      'buffer',
      'copilot',
      'emoji',
    },
    providers = {
      copilot = {
        name = "copilot",
        module = "blink-cmp-copilot",
        score_offset = 100,
        async = true,
        transform_items = function(_, items)
          local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
          local kind_idx = #CompletionItemKind + 1
          CompletionItemKind[kind_idx] = "Copilot"
          for _, item in ipairs(items) do
            item.kind = kind_idx
          end
          return items
        end,
      },
      emoji = {
        module = "blink-emoji",
        name = "Emoji",
        should_show_items = function()
          return vim.tbl_contains(
            { "gitcommit", "markdown" },
            vim.o.filetype
          )
        end,
      }
    },
    -- appearance = {
    --   kind_icons = {
    --     -- -- insert the default_kind_icons.
    --     -- table.unpack(default_kind_icons),
    --
    --     Copilot = "",
    --
    --     -- Text = '󰉿',
    --     Text = "",
    --
    --     -- Method = '󰊕',
    --     Method = "",
    --     -- Function = '󰊕',
    --     Function = "",
    --     -- Constructor = '󰒓',
    --     Constructor = "",
    --
    --     -- Field = '󰜢',
    --     Field = "",
    --     -- Variable = '󰆦',
    --     Variable = "",
    --     -- Class = '󱡠',
    --     Class = "",
    --     -- Interface = '󱡠',
    --     Interface = "",
    --
    --     -- Struct = '󱡠',
    --     Struct = "",
    --
    --     -- Module = '󰅩',
    --     Module = "",
    --
    --     -- Property = '󰖷',
    --     Property = "",
    --
    --     -- Unit = '󰪚',
    --     Unit = "",
    --
    --     -- Value = '󰦨',
    --     Value = "",
    --
    --     -- Enum = '󰦨',
    --     Enum = "",
    --
    --     -- Keyword = '󰻾',
    --     Keyword = "",
    --
    --     -- Snippet = '󱄽',
    --     Snippet = "",
    --
    --     -- Color = '󰏘',
    --     Color = "",
    --
    --     -- File = '󰈔',
    --     File = "",
    --
    --     -- Reference = '󰬲',
    --     Reference = "",
    --
    --     -- Folder = '󰉋',
    --     Folder = "",
    --
    --     -- EnumMember = '󰦨',
    --     EnumMember = "",
    --
    --     -- Constant = '󰏿',
    --     Constant = "",
    --
    --     -- Event = '󱐋',
    --     Event = "",
    --
    --     -- Operator = '󰪚',
    --     Operator = "",
    --
    --     -- TypeParameter = '󰬛',
    --     TypeParameter = "",
    --   },
    -- },
  },
}

-- Plugin.opts.sources.appearance.kind_icons["Copilot"] = ""

Plugin.opts_extend = { "sources.default" }

return Plugin
