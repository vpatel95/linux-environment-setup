local get_treesitter_dir = function()
    local dir = "/ws/vedpatel-sjc/rhel8/treesitter"
    return vim.fn.isdirectory(dir) ~= 0 and dir or ""
end

local disable_highlight = function(_, buf)
    local max_filesize = 10 * 1024 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > max_filesize then
        return true
    end
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        main = "nvim-treesitter.configs",
        build = ":TSUpdate",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects", lazy = true }
        },
        opts = function(_, opts)
            vim.treesitter.language.register("c", "npl")
            local ts_dir = get_treesitter_dir()
            if ts_dir ~= "" then
                vim.opt.runtimepath:append(ts_dir)
                opts.parser_install_dir = ts_dir
            end
            opts.ensure_installed = {
                'c', 'cpp', 'bash', 'json',
                'lua', 'python', 'vim'
            }
            opts.auto_install = true
            opts.ignore_install = { "javascript" }
            opts.highlight = {
                enable = true,
                disable = disable_highlight,
                additional_vim_regex_highlighting = false,
            }
            opts.matchup = { enable = true } --, disable = {"python"}, }
            opts.indent = { enable = false }
            opts.textobjects = {
                lsp_interop = {
                    enable = true,
                    peek_definition_code = {
                        ["<leader>df"] = "@function.outer",
                        ["<leader>dF"] = "@class.outer",
                    }
                }
            }
        end,
    }
}

