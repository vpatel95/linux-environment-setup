-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local auwrapper = function(group_name)
  local augroup = vim.api.nvim_create_augroup(group_name, { clear = true })
  return function(event, opts)
    opts.group = opts.group or augroup
    return vim.api.nvim_create_autocmd(event, opts)
  end
end

local ft_au = auwrapper("ft_au")

ft_au({ "BufRead", "BufNewFile" }, {
  pattern = { "*.c", "*.h", "*.cc", "*.hh", "*.cpp", "*.hpp" },
  callback = function()
    vim.o.shiftwidth = 4
    vim.o.softtabstop = 4
    vim.o.tabstop = 4
    -- vim.o.foldmethod = "syntax"
    vim.o.cindent = true
  end,
})

ft_au({ "BufRead", "BufNewFile" }, {
  pattern = { "*.lua" },
  callback = function()
    vim.o.shiftwidth = 2
    vim.o.softtabstop = 2
    vim.o.tabstop = 2
    vim.b.autoformat = true
  end,
})

ft_au({ "BufRead", "BufNewFile" }, {
  pattern = { "*.py" },
  callback = function()
    vim.o.shiftwidth = 4
    vim.o.softtabstop = 4
    vim.o.tabstop = 4
    -- vim.o.foldmethod = "indent"
  end,
})

ft_au({ "BufRead", "BufNewFile" }, {
  pattern = { "Makefile", "Makefile.*" },
  callback = function()
    vim.o.filetype = "make"
    vim.o.shiftwidth = 4
    vim.o.softtabstop = 4
    vim.o.tabstop = 4
    vim.o.expandtab = false
  end,
})

local format_au = auwrapper("format_au")

format_au({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\\s\\+$//e]],
})
