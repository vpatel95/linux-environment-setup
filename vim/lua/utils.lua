local M = {
    autocommands = {},
    finder = {}
}

M.autocommands.create_wrapper = function(group_name)
    local augroup = vim.api.nvim_create_augroup(group_name, { clear = true })
    return function(event, opts)
        opts.group = opts.group or augroup
        return vim.api.nvim_create_autocmd(event, opts)
    end
end

M.finder.find_files = function()
    local telescope = require("telescope.builtin")
    local is_git = (vim.fn.system "git rev-parse --is-inside-work-tree"):gsub("%s+", "")
    if string.match(is_git, "true") == nil then
        telescope.find_files()
    else
        telescope.git_files({
            file_icons = true,
        })
    end
end

function M.CheckBackspace()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return M
