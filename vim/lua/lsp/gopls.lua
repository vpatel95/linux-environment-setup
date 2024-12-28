local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

return {
    name = "gopls",
    cmd = {"gopls"},
    capabilities = capabilities,
    filetypes = {"go"},
    root_dir = lspconfig.util.root_pattern("go.mod", "go.sum", "go.work", ".git"),
    settings = {
        gopls = {
            experimentalPostfixCompletions = true,
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
        },
    },
    init_options = {
        usePlaceholders = true,
    }
}
