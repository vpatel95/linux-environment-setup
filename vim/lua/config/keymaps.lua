-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map({ "n" }, "<leader>mc", ":set mouse=c<CR>", { desc = "Set mouse cmdline", silent = true })
map({ "n" }, "<leader>ma", ":set mouse=a<CR>", { desc = "Set mouse all previous", silent = true })
