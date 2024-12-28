local capabilities = require('cmp_nvim_lsp').default_capabilities()

return {
    name = "basedpyright",
    capabilities = capabilities,
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "off"
            }
        }
    }
}
