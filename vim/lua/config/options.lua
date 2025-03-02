-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Globals
vim.g.autoformat = false
vim.g.deprecation_warnings = true

-- Options
vim.o.mouse = "c"

-- VIM commands
vim.cmd([[
set list
set listchars=tab:›\ ,trail:•,extends:❯,precedes:❮,nbsp:_
]])
