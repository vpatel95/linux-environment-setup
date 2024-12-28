local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

return {
    name = "basedpyright",
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern(
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
        ".git"
    ),
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "off",
                diagnosticMode = "openFilesOnly",
                autoImportCompletions = true
            }
        }
    }
}
