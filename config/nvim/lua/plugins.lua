return require('packer').startup(function(use)

  use 'wbthomason/packer.nvim'

  use 'nvim-lua/plenary.nvim'

  use 'ggandor/lightspeed.nvim'

  use 'nvim-lualine/lualine.nvim'

  use 'kyazdani42/nvim-tree.lua'

  use 'folke/tokyonight.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }

  use 'fannheyward/telescope-coc.nvim'

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  }

  end
)
