local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local augroup = vim.api.nvim_create_augroup("docwhatPackerConfig", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "packer.lua",
  callback = function(args)
    vim.cmd.source(args.file)
    local packer = require('packer')
    if not pcall(packer.compile) then
      packer.sync()
    end
  end,
  group = augroup
})


return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  })

  use({
    'sainnhe/gruvbox-material',
    as = 'colorscheme-gruvbox-material',
    config = function()
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_visual = 'blue background'
      vim.g.gruvbox_material_menu_selection_background = 'blue'

      local term_prog = vim.env.TERM_PROGRAM
      if term_prog == 'iTerm.app' or term_prog == 'kitty' or term_prog == 'WezTerm' then
        vim.g.gruvbox_material_enable_italic = 1
        vim.g.gruvbox_material_disable_italic_comment = 1
      end
      vim.cmd('colorscheme gruvbox-material')
    end
  })

  use('nvim-treesitter/nvim-treesitter', {
    run = ':TSUpdate',
    requires = {
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
    }
  })
  use('nvim-treesitter/playground')
  use({ 'mbbill/undotree', tag = "rel_*" })

  -- Git stuff
  use('tpope/vim-fugitive')

  -- Detect tabstop and shiftwidth automatically
  use('tpope/vim-sleuth')

  use('gpanders/editorconfig.nvim')

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },         -- Required
      { 'hrsh7th/cmp-nvim-lsp' },     -- Required
      { 'hrsh7th/cmp-buffer' },       -- Optional
      { 'hrsh7th/cmp-path' },         -- Optional
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' },     -- Optional

      -- Snippets
      { 'L3MON4D3/LuaSnip' },             -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
    },
    config = function()
      local lsp = require("lsp-zero")
      -- Fix Undefined global 'vim'
      lsp.configure('lua_ls', {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      })
    end
  }

  use('j-hui/fidget.nvim')
  -- Additional lua configuration, makes nvim stuff amazing!
  use('folke/neodev.nvim')

  if packer_bootstrap then
    require('packer').sync()
  end
end)
