local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end
execute 'packadd packer.nvim'

local packer = require('packer')
packer.reset()

vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

return packer.startup({
  function(use)
    use 'wbthomason/packer.nvim'

    use 'nvim-lua/plenary.nvim'

    use {
      'nvim-treesitter/nvim-treesitter',
      requires = {
        'nvim-treesitter/nvim-treesitter-refactor',
        'nvim-treesitter/nvim-treesitter-textobjects',
      },
      run = ':TSUpdate',
    }

    use {
      'sainnhe/gruvbox-material',
      config = function()
        vim.cmd('colorscheme gruvbox-material')
      end
    }

    use 'editorconfig/editorconfig-vim'

    use 'neovim/nvim-lspconfig'
  end,
  config = {
    display = {
      open_fn = require('packer.util').float,
      show_all_info = true,
    }
  }
})
