local keymaps = require("mappings")

return {
    {
        "stevearc/overseer.nvim",
        event = "VeryLazy",
        dependencies = { "akinsho/toggleterm.nvim" },
        opts = {
            strategy = "toggleterm",
            templates = { "builtin" }
        }
    },

    {
        'akinsho/toggleterm.nvim',
        event = "VeryLazy",
        version = "*",
        opts = {
            size = vim.api.nvim_win_get_height(0) * 0.4,
            open_mapping = "<leader>t",
        },
        init = keymaps.term,
    }
}
