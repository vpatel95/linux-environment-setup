-- lsp.lua
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

local SDK_ROOT = '/home/vedpatel/csco/src/sdk'
local leabas = {
    { device = "pacific", path = "file://" .. SDK_ROOT .. "/npl/pacific/leaba_defined" },
    { device = "gibraltar", path = "file://" .. SDK_ROOT .. "/npl/gibraltar/leaba_defined" },
    { device = "palladium", path = "file://" .. SDK_ROOT .. "/npl/akpg/palladium/leaba_defined" },
    { device = "graphene", path = "file://" .. SDK_ROOT .. "/npl/akpg/graphene/leaba_defined" }
}
local NpsuiteSettings = {
    leabaDefined = { value = leabas },
    projectLeabaDefined = { value = leabas },
    currentLeabaDefined = { value = 'gibraltar' }
}

local LanguageServerSettings = {
    trace = { server = 'verbose' }
}

local NplClientSettings = {
    Npsuite = NpsuiteSettings,
    LanguageServer = LanguageServerSettings
}

-- Check if the config is already defined (useful when reloading this file)
if not configs.npl then
    configs.npl = {
        default_config = {
            cmd = {'node', '/users/vedpatel/npl_lsp/extension/out/server/server.js', '--stdio'},
            filetypes = {'npl'},
            root_dir = function(fname)
                return lspconfig.util.find_git_ancestor(fname)
            end,
            settings = {
                npl = NplClientSettings,
                Npsuite = NpsuiteSettings,
                LanguageServer = LanguageServerSettings
            },
        },
    }
end

lspconfig.npl.setup({
    name = 'NPL Language Server',
    capabilities = capabilities,
    init_options = {
        path = "file:///users/vedpatel/csco/src/sdk/driver",
    },
    cmd = {'/users/vedpatel/bin/node', '/users/vedpatel/npl_lsp/extension/out/server/server.js', '--stdio'},
    filetypes = {'npl'},
    settings = {
        npl = NplClientSettings,
        Npsuite = NpsuiteSettings,
        LanguageServer = LanguageServerSettings
    },
})
