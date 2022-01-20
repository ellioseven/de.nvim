vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'ggandor/lightspeed.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'kyazdani42/nvim-tree.lua'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  }
  end
)
