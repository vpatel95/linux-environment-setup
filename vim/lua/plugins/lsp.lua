local keymaps = require("mappings")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        }
    },
    float = { border = "rounded" },
})

local default_config = {
  capabilities = capabilities,
  flags = { debounce_text_changes = 200 },
}

local function get_ls_config(ls)
    vim.notify("LS : " .. ls)
    local ok, config = pcall(require, "lsp." .. ls)
    if ok then
        return config
    end
    return default_config
end

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "williamboman/mason-lspconfig.nvim",
                dependencies = { "williamboman/mason.nvim" }
            }
        },
        init = function()
            keymaps.diagnostics()
            keymaps.lsp()
        end,
        config = function()
            local lspconfig = require('lspconfig')
            local lsp_handlers = {
                function(ls) lspconfig[ls].setup(get_ls_config(ls)) end,
            }

            require('mason-lspconfig').setup({
                ensure_installed = { "clangd" },
                handlers = lsp_handlers,
                automatic_installation = true,
            })
        end
    },
    {
        "williamboman/mason.nvim",
        opts = {
            install_root_dir = "/nobackup/vedpatel/local/mason",
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        }
    },
}
