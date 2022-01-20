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
