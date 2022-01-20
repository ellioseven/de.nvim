"
" .vimrc
"
" install with:
" $ nvim -u ~/.config/nvim/lua/plugins.lua --headless \
"   "-c 'autocmd User PackerComplete quitall' -c 'PackerSync'
lua require("plugins")
lua require("profile")

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

" tab defaults.
set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

" clear search.
noremap <silent> <C-L> :let @/ = ""<CR>

" read detected changes outside vim.
set autoread

" set command history.
set history=1000

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

"
" vim-plug
"

" configure plugins.
call plug#begin('~/.local/share/nvim/plugged')

" plugin: plenary.nvim
Plug 'nvim-lua/plenary.nvim'

" plugin: coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" initialise plugins.
call plug#end()
