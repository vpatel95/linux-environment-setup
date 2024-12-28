local utils = require("utils")

return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {"hrsh7th/cmp-nvim-lsp"},
            {"hrsh7th/cmp-buffer"},
            {"hrsh7th/cmp-path"},
            {"hrsh7th/cmp-cmdline"},
            {"hrsh7th/cmp-vsnip"},
            {"hrsh7th/vim-vsnip"}
        },
        opts = function()
            local cmp = require("cmp")
            return {
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
                mapping = {
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true
                    }),
                    ['C-j'] = cmp.mapping(function(fallback)
                        if vim.snippet.active({direction = -1}) then
                            vim.snippet.jump(-1)
                        else
                            fallback()
                        end
                    end, {"i", "s"}),
                    ['C-k'] = cmp.mapping(function(fallback)
                        if vim.snippet.active({direction = 1}) then
                            vim.snippet.jump(1)
                        else
                            fallback()
                        end
                    end, {"i", "s"}),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({ select = true })
                            else
                                cmp.select_next_item()
                            end
                        elseif vim.snippet.active({direction = 1}) then
                            vim.snippet.jump(1)
                        elseif utils.CheckBackspace() then
                            cmp.complete()
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({ select = true })
                            end
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ['<DOWN>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({ select = true })
                            else
                                cmp.select_next_item()
                            end
                        elseif utils.CheckBackspace() then
                            cmp.complete()
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({ select = true })
                            end
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif vim.snippet.active({direction = -1}) then
                            vim.snippet.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ['<UP>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                })
            }
        end,
    }
}
