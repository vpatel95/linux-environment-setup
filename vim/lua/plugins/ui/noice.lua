return {
    {
        "folke/noice.nvim",
        enabled = true,
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify"
        },
        opts = {
            cmdline = { view = "cmdline", },
            lsp = {
                -- progress = { enabled = false, },
                hover = { enabled = false },
                signature = { enabled = false },
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
                    ["vim.lsp.util.stylize_markdown"] = false,
                    ["cmp.entry.get_documentation"] = false,
                },
            },
            views = {
                mini = {
                    border = { style = "rounded" },
                    position = { row = -1 - vim.o.cmdheight }, -- better default
                },
            },
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
            },
            routes = {
                -- send long messages to split
                {
                    filter = {
                        min_height = 10
                    },
                    view = "messages" ,
                },
                {
                    filter = {
                        event = "msg_show",
                        kind = "",
                        any = {
                            { find = "no lines in buffer" },
                            -- Edit
                            { find = "%d+ less lines" },
                            { find = "%d+ fewer lines" },
                            { find = "%d+ more lines" },
                            { find = "%d+ change;" },
                            { find = "%d+ line less;" },
                            { find = "%d+ more lines?;" },
                            { find = "%d+ fewer lines;?" },
                            { find = '".+" %d+L, %d+B' },
                            { find = "%d+ lines yanked" },
                            { find = "^Hunk %d+ of %d+$" },
                            { find = "%d+L, %d+B$" },
                            { find = "^[/?].*" }, -- Searching up/down
                            { find = "E486: Pattern not found:" }, -- Searcingh not found
                            { find = "%d+ changes?;" }, -- Undoing/redoing
                            { find = "%d+ fewer lines" }, -- Deleting multiple lines
                            { find = "%d+ more lines" }, -- Undoing deletion of multiple lines
                            { find = "%d+ lines " }, -- Performing some other verb on multiple lines
                            { find = "Already at newest change" }, -- Redoing
                            { find = '"[^"]+" %d+L, %d+B' }, -- Saving

                            -- Save
                            { find = " bytes written" },

                            -- Redo/Undo
                            { find = " changes; before #" },
                            { find = " changes; after #" },
                            { find = "1 change; before #" },
                            { find = "1 change; after #" },

                            -- Yank
                            { find = " lines yanked" },

                            -- Move lines
                            { find = " lines moved" },
                            { find = " lines indented" },

                            -- Bulk edit
                            { find = " fewer lines" },
                            { find = " more lines" },
                            { find = "1 more line" },
                            { find = "1 line less" },

                            -- General messages
                            { find = "Already at newest change" }, -- Redoing
                            { find = "Already at oldest change" },
                        }
                    },
                },
            },
        },
    }
}
