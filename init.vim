" 
" .vimrc
"

"
" Colors.
"

" Enable syntax processig.
syntax enable

"
" Interface.
"

" Enable line numbers.
set number

" Show last command.
set showcmd

" Highlight current line.
set cursorline

" Show current position.
set ruler

" Ignore case when searching.
set ignorecase

" Add right margin on 80.
set colorcolumn=80

"
" Editing.
"

" 1 tab == 2 spaces.
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

"
" Key Mappings.
"

" Toggle NERDTree panel.
map <f8> :NERDTreeToggle<cr>

"
" Plugin Configuration.
"

" NERDTree

" Remove components from UI.
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

" Show hidden files.
let NERDTreeShowHidden=1

" vim-airline

" Enable tab line.
let g:airline#extensions#tabline#enabled = 1

"
" vim-plug
"

" Configure plugins.
call plug#begin('~/.local/share/nvim/plugged')

" Plugin: editorconfig.
Plug 'editorconfig/editorconfig-vim'

" Plugin: vim-sensible
Plug 'tpope/vim-sensible'

" Plugin: nerdtree
" Activate on toggle.
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Plugin: vim-airline
Plug 'vim-airline/vim-airline'

" Plugin: coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Plugin: vim-rust
" @url https://github.com/rust-lang/rust.vim
Plug 'rust-lang/rust.vim'
filetype plugin indent on

" Initialise plugins.
call plug#end()

