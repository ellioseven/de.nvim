" 
" .vimrc
"

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
nnoremap <silent><nowait> <leader>d  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <leader>s  :<C-u>CocList -I symbols<cr>

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

" NERDTree

" toggle NERDTree panel.
map <f8> :NERDTreeToggle<cr>

" remove components from UI.
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

" show hidden files.
let NERDTreeShowHidden=1

"
" vim-plug
"

" configure plugins.
call plug#begin('~/.local/share/nvim/plugged')

" plugin: editorconfig.
Plug 'editorconfig/editorconfig-vim'

" plugin: vim-sensible
Plug 'tpope/vim-sensible'

" plugin: nerdtree
" activate on toggle.
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" plugin: vim-lightline
Plug 'itchyny/lightline.vim'

" plugin: git-blam.vim
Plug 'f-person/git-blame.nvim'

" plugin: coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" plugin: tokyonight
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" plugin: fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" initialise plugins.
call plug#end()

"
" theming
"

" theme: tokyonight
let g:tokyonight_style = "night"
let g:tokyonight_italic_functions = 1
colorscheme tokyonight

" right margin background;
highlight ColorColumn ctermbg=0 guibg=#db4b4b

