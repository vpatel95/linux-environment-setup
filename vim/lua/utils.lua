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
  local fzf = require "fzf-lua"
  local is_git = (vim.fn.system "git rev-parse --is-inside-work-tree"):gsub("%s+", "")
  if string.match(is_git, "true") == nil then
    fzf.files()
  else
    fzf.git_files({
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

return M
