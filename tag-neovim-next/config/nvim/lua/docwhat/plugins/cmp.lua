-- Completion plugin
local M = {
  "hrsh7th/nvim-cmp",
}

M.dependencies = {
  "lsp-zero.nvim",
  "copilot-cmp",

  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-cmdline",

  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",
  "saadparwaiz1/cmp_luasnip",

  "lukas-reineke/cmp-under-comparator",
}

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

M.config = function()
  vim.g.completeopt = "menu,menuone,noselect,noinsert"

  require("luasnip.loaders.from_vscode").lazy_load()

  local cmp = require("cmp")
  local cmp_action = require("lsp-zero").cmp_action()
  local lspkind = require("lspkind")
  local luasnip = require("luasnip")
  local compare = require("cmp.config.compare")

  local source_mapping = {
    luasnip = " snip",
    nvim_lsp = "󰯓 lsp",
    buffer = "󰓩 buf",
    nvim_lua = " lua",
    orgmode = " org",
    cmdline = " cmd",
    crates = " cr8",
    nvim_lsp_signature_help = "󰏚 sign",
    path = "󰙅 path",
    Copilot = "",
  }

  -- Copilot LspKind color
  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

  local function border(hl_name)
    return {
      { "╭", hl_name },
      { "─", hl_name },
      { "╮", hl_name },
      { "│", hl_name },
      { "╯", hl_name },
      { "─", hl_name },
      { "╰", hl_name },
      { "│", hl_name },
    }
  end

  local setup_opts = {
    preselect = cmp.PreselectMode.None,

    window = {
      completion = {
        border = border("CmpBorder"),
        winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
      },
      documentation = {
        border = border("CmpDocBorder"),
        winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
      },
    },

    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    enabled = function()
      -- disable completion in comments
      local context = require("cmp.config.context")
      -- keep command mode completion enabled when cursor is in a comment
      if vim.api.nvim_get_mode().mode == "c" then
        return true
      else
        return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
      end
    end,

    sorting = {
      priority_weight = 2,
      comparators = {
        require("copilot_cmp.comparators").prioritize,

        -- Below is the default comparitor list and order for nvim-cmp
        compare.offset,
        -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
        compare.exact,
        compare.score,
        require("cmp-under-comparator").under, -- Not default list.
        compare.recently_used,
        compare.locality,
        compare.kind,
        compare.sort_text,
        compare.length,
        compare.order,
      },
    },

    mapping = {
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),

      -- Scroll up and down in the completion documentation
      ["<C-u>"] = cmp.mapping.scroll_docs(-4),
      ["<C-d>"] = cmp.mapping.scroll_docs(4),

      -- Ctrl+Space to trigger completion menu
      ["<C-Space>"] = cmp.mapping.complete(),

      -- Navigate between snippet placeholder
      ["<Tab>"] = vim.schedule_wrap(function(fallback)
        if cmp.visible() then
          if has_words_before() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
            return
          end
        elseif luasnip.expand_or_jumpable() then
          cmp_action.luasnip_jump_forward()
          return
        end

        fallback()
      end),
      ["<S-Tab>"] = vim.schedule_wrap(function(fallback)
        if not cmp.visible() and luasnip.jumpable(-1) then
          cmp_action.luasnip_jump_backward()
          return
        end

        fallback()
      end),

      ["<C-e>"] = cmp.mapping.close(),
      ["<C-c>"] = cmp.mapping.close(),
      ["<C-g>"] = cmp.mapping.abort(),

      ["<C-y>"] = cmp.config.disable,

      -- `Enter` key to confirm completion
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      ["<S-CR>"] = cmp.mapping.confirm({ select = true }),
    },

    sources = cmp.config.sources({
      { name = "copilot", priority = 100 },
      { name = "nvim_lsp", priority = 90 },
      { name = "nvim_lsp_signature_help", priority = 90 },
      { name = "nvim_lua", priority = 80 },
      { name = "path" },
      { name = "cmdline" },
      { name = "crates" },
      { name = "orgmode" },
    }, {
      { name = "buffer", keyword_length = 3 },
      { name = "luasnip" },
    }),

    formatting = {
      format = function(entry, vim_item)
        lspkind.cmp_format({ with_text = true, maxwidth = 50 })
        vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
        vim_item.menu = source_mapping[entry.source.name]
        local maxwidth = 80
        vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
        return vim_item
      end,
    },

    -- experimental = {
    --   ghost_text = false,
    -- },

    completion = { completeopt = "menu,menuone,noinsert" },
  }

  cmp.setup(setup_opts)

  cmp.setup.cmdline(":", {
    -- mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      {
        name = "cmdline",
        option = {
          ignore_cmds = { "Man", "!" },
        },
      },
    }),

    enabled = function()
      -- Set of commands where cmp will be disabled
      local disabled = {
        IncRename = true,
      }
      -- Get first word of cmdline
      local cmd = vim.fn.getcmdline():match("%S+")
      -- Return true if cmd isn't disabled
      -- else call/return cmp.close(), which returns false
      return not disabled[cmd] or cmp.close()
    end,
  })

  -- `/`, `?` cmdline setup.
  cmp.setup.cmdline({ "?", "/" }, {
    -- mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  require("luasnip").config.set_config({ history = true, updateevents = "TextChanged,TextChangedI" })
end

return M
