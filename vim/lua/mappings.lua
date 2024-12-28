-- Mappings
local M = {}

local finder = require("utils").finder
vim.api.nvim_create_user_command("FindFiles", finder.find_files, {})


-- m[1] = key sequence, m[2] = action, m[3] = options
local function map(keymaps, keymap_opts, extra_opts)
    extra_opts = extra_opts or {}
    local lazy_keymaps = extra_opts.lazy and {}
    keymap_opts = keymap_opts or {}
    for modes, maps in pairs(keymaps) do
        for _, m in pairs(maps) do
            local opts = vim.tbl_extend("force", keymap_opts, m[3] or {})
            if extra_opts.lazy then
                table.insert(lazy_keymaps, vim.tbl_extend("force", { m[1], m[2], mode = modes }, opts))
            else
                vim.keymap.set(modes, m[1], m[2], opts)
            end
        end
    end
    return lazy_keymaps
end

M.regular = function()
    map({
        [{"n"}] = {
            { "<leader>w", ":bn<CR>", { desc = "Buffer Next" } },
            { "<leader>q", ":bn<CR>", { desc = "Buffer Previous" } },
            { "<leader>n", ":tabn<CR>", { desc = "Tab Next" } },
            { "<leader>p", ":tabp<CR>", { desc = "Tab Previous" } },
            { '<leader>mc', ':set mouse=c<CR>', { desc = "Mouse CLI" } },
            { '<leader>ma', ':set mouse=a<CR>', { desc = "Mouse All" } },
            { '<leader>sn', ':set number<CR>', { desc = "Numbers" } },
            { '<leader>sr', ':set relativenumber<CR>', { desc = "Relative Numbers" }  },
            { '<leader>snn', ':set nonumber <bar> set norelativenumber<CR>', { desc = "No number" } },
            { '<leader>snr', ':set norelativenumber<CR>', { desc = "No relative number" } },
            { '<leader>cws', ':%s/\\s\\+$//e<CR>', { desc = "Clear whitespace" } },
            { '<leader>d', '<cmd>Neotree toggle<CR>' },
        },
    }, { remap = false, silent = true})
end

M.telescope = function()
    map({
        [{"n"}] = {
            { '<C-f>', '<cmd>FindFiles<CR>', { desc = "(Telescope) Files" } },
            { '<leader>fb', '<cmd>Telescope buffers<CR>', { desc = "(Telescope) Buffers" } },
            { '<leader>fg', '<cmd>Telescope live_grep<CR>', { desc = "(Telescope) Grep" } },
            { '<leader>gb', '<cmd>Telescope git_branches<CR>', { desc = "(Telescope) Git branch" } },
            { '<leader>gs', '<cmd>Telescope git_stash<CR>', { desc = "(Telescope) Git stash" } },
            { '<leader>fw', '<cmd>Telescope grep_string<CR>', { desc = "(Telescope) String search" } },
        },
    }, { remap = false, silent = true })
end

M.lsp = function()
    local lsp = vim.lsp.buf
    map({
        [{ "n" }] = {
            { "gD", vim.lsp.buf.declaration, { desc = "(LSP) Declaration" } },
            { "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "(LSP) Definition" } },
            { "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "(LSP) Implementation" } },
            { "gr", "<cmd>Telescope lsp_references<CR>", { desc = "(LSP) References" } },
            { "gs", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", { desc = "(LSP) WS Symbols" } },
            { "gk", lsp.signature_help, { desc = "(LSP) Get signature help" } },
            { "ga", lsp.code_action, { desc = "(LSP) Get code actions" } },
            { "<leader>D", "<cmd>Telescope lsp_type_definition<CR>", { desc = "(LSP) Get type" } },
            { "K", lsp.hover, { desc = "(LSP) Hover" } },
            { "<leader>wa", lsp.add_workspace_folder, { desc = "(LSP) Add workspace folder" } },
            { "<leader>wr", lsp.remove_workspace_folder, { desc = "(LSP) Remove workspace folder" } },
            {
                "<leader>wl",
                function() vim.print(lsp.list_workspace_folders()) end,
                { desc = "(LSP) Get workspace folders" },
            },
            {
                "<leader>ih",
                "<cmd>lua lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled())<CR>",
                { desc = "(LSP) Toggle Inlay Hints" }
            }
        },
    }, { remap = false, silent = true})
end

M.diagnostics = function()
    local diag = vim.diagnostic
    map({
        [{ "n" }] = {
            { "<leader>k", diag.open_float, { desc = "Floating Diagnostics" } },
            { "[d", diag.goto_prev, { desc = "Previous diagnostic" } },
            { "]d", diag.goto_next, { desc = "Next diagnostic" } },
            { "<leader>dl", diag.setloclist, { desc = "Add diagnostics to location list" } },
        },
    })
end

M.lualine = function()
    map({
        [{"n"}] = {
            { '<leader>1', ':LualineBuffersJump 1<CR>' },
            { '<leader>2', ':LualineBuffersJump 2<CR>' },
            { '<leader>3', ':LualineBuffersJump 3<CR>' },
            { '<leader>4', ':LualineBuffersJump 4<CR>' },
            { '<leader>5', ':LualineBuffersJump 5<CR>' },
            { '<leader>6', ':LualineBuffersJump 6<CR>' },
            { '<leader>7', ':LualineBuffersJump 7<CR>' },
            { '<leader>8', ':LualineBuffersJump 8<CR>' },
            { '<leader>9', ':LualineBuffersJump 9<CR>' },
        },
    }, { remap = false, silent = true})
end

M.gitsigns = function()
    map({
        [{"n"}] = {
            { '<leader>hp', ':Gitsigns prev_hunk<CR>', { desc = "(Git) Previous Hunk" } },
            { '<leader>hn', ':Gitsigns next_hunk<CR>', { desc = "(Git) Next Hunk" } },
            { '<leader>hd', ':Gitsigns preview_hunk<CR>', { desc = "(Git) Preview Hunk" } },
            { '<leader>hu', ':Gitsigns reset_hunk<CR>', { desc = "(Git) Reset Hunk" } },
            { '<leader>hs', ':Gitsigns stage_hunk<CR>', { desc = "(Git) Stage Hunk" } },
        },
    }, { remap = false, silent = true})
end

M.zen = function()
    map({
        [{"n"}] = {
            { '<leader>zn', ':TZNarrow<CR>', { desc = "(Zen) Narrow" } },
            { '<leader>zf', ':TZFocus<CR>', { desc = "(Zen) Focus" } },
            { '<leader>zm', ':TZMinimalist<CR>', { desc = "(Zen) Mininmalist" } },
            { '<leader>zz', ':TZAtaraxis<CR>', { desc = "(Zen) Ataraxis" } },
        }
    }, {remap = false, silent = true})
end

M.trouble = function(opts)
    return map({
        [{ "n" }] = {
            { "<leader>T", "<Cmd>Trouble<CR>", { desc = "Trouble" } },
            {
                "<leader>TD",
                "<Cmd>Trouble lsp_declaration toggle focus=true<CR>",
                { desc = "(Trouble) Get declaration" }
            },
            {
                "<leader>Td",
                "<Cmd>Trouble lsp_definition toggle focus=true<CR>",
                { desc = "(Trouble) Get definition" }
            },
            {
                "<leader>Ti",
                "<Cmd>Trouble lsp_implementation toggle focus=true<CR>",
                { desc = "(Trouble) Get implementation" }
            },
            {
                "<leader>Tr",
                "<Cmd>Trouble lsp_references toggle focus=true<CR>",
                { desc = "(Trouble) Get references" }
            },
            {
                "<leader>Ts",
                "<Cmd>Trouble lsp_document_symbols toggle focus=true<CR>",
                { desc = "(Trouble) Get document symbols" }
            },
        },
    }, {}, opts)
end

return M

--     ["n"] = {
--         { '<leader>s', ':silent! TagbarToggle<CR>', { noremap = true, silent = true } },
--         { '<leader>g', ':silent! GundoToggle<CR>', { noremap = true, silent = true } },
--         { '<space>w', ':<C-u>MatchupWhereAmI?<CR>', { noremap = true, silent = true, nowait = true } },
--     },
