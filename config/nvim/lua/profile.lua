-- globals

local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- remap space as leader.
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- show preview on search-replace.
cmd "set inccommand=split"

-- disable line wraps.
cmd ":set wrap!"

cmd "set updatetime=300"

-- use configured colours instead of cterm.
-- @url https://www.reddit.com/r/neovim/comments/dfe7gq/why_does_termguicolors_change_the_way_things_are/
cmd "set termguicolors"

-- enable syntax processing.
cmd "syntax enable"

-- fold all by default.
-- @todo Seems to be broken on live_grep?
-- @url https://stackoverflow.com/questions/2362914/fold-function-in-vim
-- cmd "set foldmethod=syntax"

-- always show 10 lines on scroll.
cmd "set scrolloff=10"

-- tab defaults.
cmd "set autoindent"
cmd "set backspace=indent,eol,start"
cmd "set complete-=i"
cmd "set smarttab"

-- clear search.
map('n', '<c-l>', ':let @/ = ""<CR>', { silent = true, noremap = true })

-- read detected changes outside vim.
cmd "set autoread"

-- set command history.
cmd "set history=1000"

-- enable line numbers.
cmd "set number"

-- show last command.
cmd "set showcmd"

-- highlight current line.
cmd "set cursorline"

-- show current position.
cmd "set ruler"

-- ignore case when searching.
cmd "set ignorecase"

-- add mapping to toggle right margin.
map('n', '<leader>c', ':execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>')

-- 1 tab == 2 spaces.
cmd "set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab"

-- theme: tokyonight.nvim

g.tokyonight_style = 'night'
g.tokyonight_italic_functions = 0
g.tokyonight_dark_float = 1
g.tokyonight_transparent_sidebar = 1
g.tokyonight_colors = {
--  bg_float = '#1a1b26'
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
      left = '|',
      right = '|'
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

-- plugin: coc.nvim

vim.api.nvim_set_keymap('n', '<leader>dn', '<Plug>(coc-diagnostic-next)', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>dp', '<Plug>(coc-diagnostic-prev)', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>gd', '<Plug>(coc-definition)', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>gi', '<Plug>(coc-implementation)', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>gt', '<Plug>(coc-type-definition)', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>rn', '<Plug>(coc-rename)', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>ca', '<Plug>(coc-codeaction-selected)', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>ol', ':call CocActionAsync("showOutline")<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>do', ':call CocActionAsync("doHover")<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fo', ':call CocActionAsync("fold")<CR>', { silent = true, noremap = true })

-- highlight the symbol and its references when holding the cursor.
-- @url https://stackoverflow.com/questions/41416072/change-the-hold-time-of-the-cursor
cmd "autocmd CursorHold * silent call CocActionAsync('highlight')"

-- plugin: telescope.nvim

require('telescope').setup({
  defaults = {
    theme = "tokyonight",
    layout_config = {
      vertical = { width = 1 },
      preview_width = 80
    },
  },
})

-- plugin: telescope-fzf.nvim

require('telescope').load_extension('fzf')

map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>')
map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>')
map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>')
map('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>')
map('n', '<leader>fs', '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<cr>')

-- plugin: telescope-coc.nvim

require('telescope').load_extension('coc')

map('n', '<leader>di', ':<C-u>Telescope coc diagnostics<cr>')
map('n', '<leader>re', ':<C-u>Telescope coc references<cr>')

-- plugin: indent-blankline.nvim

require('indent_blankline').setup()

-- plugin: which-key.nvim

local wk = require('which-key')

wk.register({
  ["<leader>"] = {
    f = {
      name = "file",
      z = "Do something"
    },
  },
})


-- plugin: zen.nvim

map('n', '<leader>zm', ':ZenMode<cr>')

