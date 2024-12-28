local keymaps = require("mappings")

return {
    {
        "folke/trouble.nvim",
        config = true,
        cmd = "Trouble",
        keys = keymaps.trouble({
            lazy = true,
        }),
    },

}
