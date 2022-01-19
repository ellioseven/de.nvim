" 
" .vimrc
"

" use configured colours instead of cterm.
" @url https://www.reddit.com/r/neovim/comments/dfe7gq/why_does_termguicolors_change_the_way_things_are/
set termguicolors

" enable syntax processig.
syntax enable

" remove vertical divider
" @url https://stackoverflow.com/questions/26582597/why-my-vim-split-window-line-so-ugly
set fillchars-=vert:\| | set fillchars+=vert:\ 
highlight VertSplit cterm=NONE

" fold all by default.
" @url https://stackoverflow.com/questions/2362914/fold-function-in-vim
:set foldmethod=syntax

" always show 10 lines on scroll.
:set scrolloff=10

"
" interface.
"

" enable line numbers.
set number

" show last command.
set showcmd

" highlight current line.
set cursorline

" show current position.
set ruler

" ignore case when searching.
set ignorecase

" add right margin on 80.
" set colorcolumn=80

" add mapping to toggle right margin/
nnoremap <leader>c :execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>

"
" editing.
"

" 1 tab == 2 spaces.
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

"
" plugin configuration.
"

" CoC

" 
set signcolumn=number

" use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)
nnoremap <silent> K :call <SID>show_documentation()<CR>

" highlight the symbol and its references when holding the cursor.
" @url https://stackoverflow.com/questions/41416072/change-the-hold-time-of-the-cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
set updatetime=300

" show documentation on key.
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" status function, includes diagnostic counts and status.
function! CocStatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'ERR:' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'WARN:' . info['warning'])
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

" lightline

let g:lightline = {
  \   'colorscheme': 'tokyonight',
  \   'active': {
  \     'left': [
  \       [ 'mode', 'paste' ],
  \       [ 'cocstatus', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
  \   'component_function': {
  \     'cocstatus': 'CocStatusDiagnostic'
  \   }
  \ }

"
" vim-plug
"

" configure plugins.
call plug#begin('~/.local/share/nvim/plugged')

" plugin: plenary.nvim
Plug 'nvim-lua/plenary.nvim'

" plugin: editorconfig.
Plug 'editorconfig/editorconfig-vim'

" plugin: vim-sensible
Plug 'tpope/vim-sensible'

" plugin: vim-lightline
Plug 'itchyny/lightline.vim'

" plugin: coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" plugin: tokyonight
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" plugin: nvim-tree.lua
Plug 'kyazdani42/nvim-tree.lua'

" plugin: lightspeed.vim
Plug 'ggandor/lightspeed.nvim'

" plugin gitsigns.vim
Plug 'lewis6991/gitsigns.nvim'

" plugin telescope.nvim
Plug 'nvim-telescope/telescope.nvim'

" plugin: telescope-coc.nvim
Plug 'fannheyward/telescope-coc.nvim'

" plugin: telescope-fzf.nvim
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" initialise plugins.
call plug#end()

"
" theming
"

" theme: tokyonight
let g:tokyonight_style = "night"
let g:tokyonight_italic_functions = 1
let g:tokyonight_transparent_sidebar = 1
let g:tokyonight_colors = {
  \   'bg_float': '#1a1b26',
  \ }

colorscheme tokyonight

" right margin background;
highlight ColorColumn ctermbg=0 guibg=#db4b4b

" nvim-tree

nnoremap <C-n> :NvimTreeToggle<CR>

" disable style for executables.
" @url https://github.com/kyazdani42/nvim-tree.lua/issues/273
hi! def NvimTreeExecFile guifg=none guibg=none gui=NONE

let g:nvim_tree_indent_markers = 1
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 0,
    \ 'folder_arrows': 0,
    \ }
let g:nvim_tree_icons = {
    \ 'git': {
    \   'unstaged': '∘',
    \   'staged': '•',
    \   'renamed': '•',
    \   'untracked': '∘',
    \   'deleted': "•",
    \   },
    \ 'folder': {
    \   'arrow_open': "▿",
    \   'arrow_closed': "▹",
    \   'default': "▹",
    \   'open': "▿",
    \   'empty': "▫",
    \   'empty_open': "▿",
    \   'symlink': "▫",
    \   'symlink_open': "▿",
    \   }
    \ }

lua << EOF
require'nvim-tree'.setup {
  view = {
    width = 40,
    hide_root_folder = true,
  }
}
EOF

" gitsigns.nvim

lua << EOF
require'gitsigns'.setup {
  current_line_blame = true
}
EOF

" telescope.nvim

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

let g:tokyonight_dark_float = 1

lua << EOF
require('telescope').setup({
  defaults = {
    theme = "tokyonight",
    layout_config = {
      vertical = { width = 1 },
      preview_width = 80
    },
  },
})
EOF

" telescope-fzf.nvim

lua << EOF
require('telescope').load_extension('fzf')
EOF

" telescope-coc.nvim

lua << EOF
require('telescope').load_extension('coc')
EOF

nnoremap <silent><nowait> <leader>d  :<C-u>Telescope coc diagnostics<cr>
nnoremap <silent><nowait> <leader>dd  :<C-u>Telescope coc workspace_diagnostics<cr>
nnoremap <silent><nowait> <leader>r  :<C-u>Telescope coc references<cr>

