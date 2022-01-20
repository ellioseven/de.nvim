--
-- init.lua
--
-- install:
-- $ nvim -u ~/.config/nvim/lua/plugins.lua --headless \
--   "-c 'autocmd User PackerComplete quitall' -c 'PackerSync'
--
--
-- recompile:
-- $ nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
--

require("plugins")
require("profile")
