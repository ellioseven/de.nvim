"
" .vimrc
"
" install with:
" $ nvim -u ~/.config/nvim/lua/plugins.lua --headless \
"   "-c 'autocmd User PackerComplete quitall' -c 'PackerSync'
lua require("plugins")
lua require("profile")
