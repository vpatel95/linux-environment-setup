local autocmds = require("utils").autocommands

-- Filetype based settings
autocmds.create({"BufRead", "BufNewFile"}, {
    pattern = {"*.c", "*.h", "*.cc", "*.hh", "*.cpp", "*.hpp", "*.npl"},
    callback = function()
        vim.o.foldmethod = "syntax"
        vim.o.cindent = true
    end
})

autocmds.create({"BufRead", "BufNewFile"}, {
    pattern = {"*.py"},
    callback = function()
        vim.o.foldmethod = "indent"
    end
})

-- LSP auto commands
autocmds.create({"CursorHold", "CursorHoldI"}, {
    pattern = {"*"},
    command = "lua vim.diagnostic.open_float(nil, {focus=false})"
})

return {}
