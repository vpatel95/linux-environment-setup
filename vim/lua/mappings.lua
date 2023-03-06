-- Mappings
print("mappings still in old nvim init")

local function map(mode, shortcut, command, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, shortcut, command, options)
end

function nnoremap(mode, shortcut, command)
    map('n', shortcut, command, {noremap = true})
end

function nmap(shortcut, command)
    map('n', shortcut, command)
end

function imap(shortcut, command)
    map('i', shortcut, command)
end
