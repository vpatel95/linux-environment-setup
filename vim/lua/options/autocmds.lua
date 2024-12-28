local autocmds = require("utils").autocommands

-- Filetype based settings
local ft_aucreate = autocmds.create_wrapper("filetypes_au")
ft_aucreate({"BufRead", "BufNewFile"}, {
    group = "filetypes_au",
    pattern = {"*.npl"},
    callback = function()
        vim.o.filetype = "npl"
    end
})

ft_aucreate({"BufRead", "BufNewFile"}, {
    group = "filetypes_au",
    pattern = {"*.c", "*.h", "*.cc", "*.hh", "*.cpp", "*.hpp", "*.npl"},
    callback = function()
        vim.o.foldmethod = "syntax"
        vim.o.cindent = true
    end
})

ft_aucreate({"BufRead", "BufNewFile"}, {
    group = "filetypes_au",
    pattern = {"*.py"},
    callback = function()
        vim.o.foldmethod = "indent"
    end
})

-- LSP auto commands
local lsp_aucreate = autocmds.create_wrapper("lsp_au")
lsp_aucreate({"CursorHold", "CursorHoldI"}, {
    group = "lsp_au",
    pattern = {"*"},
    command = "lua vim.diagnostic.open_float(nil, {focus=false})"
})

return {}
