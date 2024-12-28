local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

return {
    name = 'clangd',
    cmd = {'clangd',
    '--header-insertion=never', '--clang-tidy',
    '--background-index', '--background-index-priority=low',
    '--enable-config', '-j=8', '--offset-encoding=utf-8'},
    capabilities = capabilities,
    filetypes = {'c', 'cc', 'cpp', 'h', 'hh', 'hpp', 'proto'},
    root_dir = lspconfig.util.root_pattern('compile_commands.json'),
}
