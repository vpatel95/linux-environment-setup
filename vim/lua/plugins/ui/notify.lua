return {
    "rcarriga/nvim-notify",
    config = function()
        local notify = require("notify")
        notify.setup({
            stages = "static",
            timeout = 2500,
        })
    end,
}
