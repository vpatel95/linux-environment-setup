-- npl.lua
-- To configure custom language server not supported by neovim-lspconfig
-- 1. Extend existing neovim-lspconfig table with default config.
--    - We just define the default config here. Extending is done in plugins/lsp.lua
-- 2. Also provide a custom LS config.
-- 3. Call setup_custom_ls({"ls1", "ls2", ...}) during neovim-lspconfig setup
local M = {}
local capabilities = require("cmp_nvim_lsp").default_capabilities()

M.default_config = {
    cmd = {"example_command", "--example-args"},
    filetypes = {"example"},
    root_dir = function(fname)
        return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
    end,
}

M.setup_config = {
    name = "Example Language Server",
    capabilities = capabilities,
    cmd = {"example_command", "--example-args"},
}

return M
