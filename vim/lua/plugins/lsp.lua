local keymaps = require("mappings")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        }
    },
    float = { border = "rounded" },
})

local default_config = {
  capabilities = capabilities,
  flags = { debounce_text_changes = 200 },
}

local function get_ls_config(ls)
    local ok, config = pcall(require, "lsp." .. ls)
    if ok then
        return config
    end
    return default_config
end

local setup_custom_ls = function(custom_ls)
    local lspconfig = require("lspconfig")
    local configurations = require("lspconfig.configs")
    for _, ls in ipairs(custom_ls) do
        local ok, configs = pcall(require, "lsp.custom." .. ls)
        if ok then
            if not configurations[ls] then
                configurations[ls].default_config = configs.default_config
            end
            lspconfig[ls].setup(configs.setup_config)
        end
    end
end

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
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
            local lspconfig = require("lspconfig")
            local lsp_handlers = {
                function(ls) lspconfig[ls].setup(get_ls_config(ls)) end,
            }

            require("mason-lspconfig").setup({
                ensure_installed = { "clangd" },
                handlers = lsp_handlers,
                automatic_installation = { exclude = { "npl" } },
            })

            -- setup_custom_ls({"example"})

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
