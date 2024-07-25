local M = {}

function M.define_augroups(definitions) -- {{{1
    -- Create autocommand groups based on the passed definitions
    --
    -- The key will be the name of the group, and each definition
    -- within the group should have:
    --    1. Trigger
    --    2. Pattern
    --    3. Text
    -- just like how they would normally be defined from Vim itself
    for group_name, definition in pairs(definitions) do
        vim.cmd("augroup " .. group_name)
        vim.cmd("autocmd!")

        for _, def in pairs(definition) do
            local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
            vim.cmd(command)
        end

        vim.cmd("augroup END")
    end
end

function M.find_files()
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

function M.find_buffers()
    local results = {}
    local buffers = vim.api.nvim_list_bufs()

    for _, buffer in ipairs(buffers) do
        if vim.api.nvim_buf_is_loaded(buffer) then
            local filename = vim.api.nvim_buf_get_name(buffer)
            table.insert(results, filename)
        end
    end

    vim.ui.select(results, { prompt = "Find buffer:" }, function(selected)
        if selected then
            vim.api.nvim_command("buffer " .. selected)
        end
    end)
end

function M.register_mappings(mappings, default_options)
    for mode, mode_mappings in pairs(mappings) do
        for _, mapping in pairs(mode_mappings) do
            local options = #mapping == 3 and table.remove(mapping) or default_options
            local prefix, cmd = unpack(mapping)
            pcall(vim.api.nvim_set_keymap, mode, prefix, cmd, options)
        end
    end
end

function M.CheckBackspace()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return M
