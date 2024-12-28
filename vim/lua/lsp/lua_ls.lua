local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

return {
    name = 'lua_ls',
    capabilities = capabilities,
    filetypes = {"lua"},
    root_dir = lspconfig.util.root_pattern("init.lua", ".luarc.json", ".luarc.jsonc"),
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
        },
    },
}
