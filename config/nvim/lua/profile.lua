-- globals

local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- theme: tokyonight.nvim

g.tokyonight_style = 'night'
g.tokyonight_italic_functions = 1
g.tokyonight_dark_float = 1
g.tokyonight_transparent_sidebar = 1
g.tokyonight_colors = {
  bg_float = '#1a1b26'
}

-- enable theme.
cmd[[colorscheme tokyonight]]

-- right margin background.
cmd "highlight ColorColumn ctermbg=0 guibg=#db4b4b"

-- plugin: lualine.nvim

require('lualine').setup({
  options = {
    icons_enabled = false,
    theme = 'tokyonight',
    component_separators = {
      left = '',
      right = ''
    },
    section_separators = {
      left = '',
      right = ''
    },
  },
  sections = {
    lualine_a = {
      'mode'
    },
    lualine_b = {},
    lualine_c = {
      'branch',
      {
        'diagnostics',
        symbols = {
          error = 'ERR:',
          warn = 'WRN:',
          info = 'INF:'
        }
      },
      'filename',
    },
    lualine_x = {
      'encoding',
      'fileformat',
      'filetype'
    },
    lualine_y = {
      'progress'
    },
    lualine_z = {
      'location'
    }
  }
})

-- plugin: nvim-tree.lua

g.nvim_tree_indent_markers = 1

g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 0,
  folder_arrows = 0,
}

g.nvim_tree_icons = {
  git = {
    unstaged = '∘',
    staged = '•',
    renamed = '•',
    untracked = '∘',
    deleted = "•",
  },
  folder = {
    arrow_open = "▿",
    arrow_closed = "▹",
    default = "▹",
    open = "▿",
    empty = "▫",
    empty_open = "▿",
    symlink = "▫",
    symlink_open = "▿",
  }
}

map('n', '<c-n>', ':NvimTreeToggle<CR>')

-- disable style for executables.
-- @url https://github.com/kyazdani42/nvim-tree.lua/issues/273
cmd "hi! def NvimTreeExecFile guifg=none guibg=none gui=NONE"

require('nvim-tree').setup({
  view = {
    width = 40,
    hide_root_folder = true,
  }
})

-- plugin: gitsigns.nvim

require('gitsigns').setup({
  current_line_blame = true
})

