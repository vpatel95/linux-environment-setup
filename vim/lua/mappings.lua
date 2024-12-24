-- Mappings
local utils = require('utils')
local fn = vim.fn
local cmd = vim.cmd


cmd([[
function FormatCpp()
  if !empty(findfile('~/.clang-format'))
    let cursor_pos = getpos('.')
    :%!git clang-format -f %:p
    call setpos('.', cursor_pos)
  endif
endfunction
]])


local mappings = {
    ["i"] = {
        { '<leader>ci', ':set cindent<CR>' },
        { '<C-f>', '<cmd>lua require("utils").find_files()<CR>', { noremap = true, silent = true } },
        { '<leader>fb', '<cmd>Telescope buffers<CR>', {noremap = true, silent = true } },
        { '<leader>fg', '<cmd>Telescope live_grep<CR>', {noremap = true, silent = true } },
        { '<leader>gb', '<cmd>Telescope git_branches<CR>', {noremap = true, silent = true } },
        { '<leader>gs', '<cmd>Telescope git_stash<CR>', {noremap = true, silent = true } },
        { '<leader>fw', ':Ag<CR>' },
    },
    ["n"] = {
        { '<C-L>', ':silent! nohl<CR><C-L>', { noremap = true, silent = true } },
        { '<leader>d', ':silent! NvimTreeToggle<CR>', { noremap = true, silent = true } },
        { '<leader>s', ':silent! TagbarToggle<CR>', { noremap = true, silent = true } },
        { '<leader>g', ':silent! GundoToggle<CR>', { noremap = true, silent = true } },


        { '<leader>zn', ':TZNarrow<CR>' },
        { '<leader>zf', ':TZFocus<CR>', { noremap = true, silent = true } },
        { '<leader>zm', ':TZMinimalist<CR>' },
        { '<leader>zz', ':TZAtaraxis<CR>' },

        { '<leader>nhs', ':nohlsearch<CR>', { noremap = true} },

        { '<leader>fe', ':set foldenable<CR>' },
        { '<leader>fd', ':set nofoldenable<CR>' },

        { '<leader>sn', ':set number<CR>' },
        { '<leader>sr', ':set relativenumber<CR>' },
        { '<leader>snn', ':set nonumber <bar> set norelativenumber<CR>' },
        { '<leader>snr', ':set norelativenumber<CR>' },

        { '<leader>q', ':bp<CR>' },
        { '<leader>w', ':bn<CR>' },
        { '<leader>n', ':tabn<CR>' },
        { '<leader>p', ':tabp<CR>' },
        { '<leader>1', ':LualineBuffersJump 1<CR>' },
        { '<leader>2', ':LualineBuffersJump 2<CR>' },
        { '<leader>3', ':LualineBuffersJump 3<CR>' },
        { '<leader>4', ':LualineBuffersJump 4<CR>' },
        { '<leader>5', ':LualineBuffersJump 5<CR>' },
        { '<leader>6', ':LualineBuffersJump 6<CR>' },
        { '<leader>7', ':LualineBuffersJump 7<CR>' },
        { '<leader>8', ':LualineBuffersJump 8<CR>' },
        { '<leader>9', ':LualineBuffersJump 9<CR>' },

        { '<leader>hp', ':Gitsigns prev_hunk<CR>' },
        { '<leader>hn', ':Gitsigns next_hunk<CR>' },
        { '<leader>hd', ':Gitsigns preview_hunk<CR>' },
        { '<leader>hu', ':Gitsigns reset_hunk<CR>' },
        { '<leader>hs', ':Gitsigns stage_hunk<CR>' },

        { '<leader>mc', ':set mouse=c<CR>' },
        { '<leader>ma', ':set mouse=a<CR>' },

        { '<leader>cws', ':%s/\\s\\+$//e<CR>' },

        { '<leader>ci', ':set cindent<CR>' },

        { '<leader>fw', ':Ag<CR>' },
        { '<C-f>', '<cmd>lua require("utils").find_files()<CR>', { noremap = true, silent = true } },
        { '<leader>fb', '<cmd>Telescope buffers<CR>', {noremap = true, silent = true } },
        { '<leader>fg', '<cmd>Telescope live_grep<CR>', {noremap = true, silent = true } },
        { '<leader>gb', '<cmd>Telescope git_branches<CR>', {noremap = true, silent = true } },
        { '<leader>gs', '<cmd>Telescope git_stash<CR>', {noremap = true, silent = true } },
        { '<leader>fw', '<cmd>Telescope grep_string<CR>', { noremap = true } },

        { 'gd', '<cmd>Telescope lsp_definitions<CR>' },
        { 'vd', '<cmd>lua require("telescope.builtin").lsp_definitions({jump_type="vsplit"})<CR>' },
        { 'gr', '<cmd>Telescope lsp_references<CR>' },
        { 'gt', '<cmd>Telescope lsp_type_definitions<CR>' },
        { 'cg', '<cmd>Telescope lsp_incoming_calls<CR>'},
        { '<space>s', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>' },
        { 'gg', vim.lsp.buf.declaration, { silent = true } },
        { 'hd', vim.lsp.buf.hover, { silent = true } },
        { 'suh', vim.lsp.buf.typehierarchy, {silent = true } },
        { 'sbh', vim.lsp.buf.typehierarchy, {silent = true } },

        { '<space>w', ':<C-u>MatchupWhereAmI?<CR>', { noremap = true, silent = true, nowait = true } },
        { '<leader>ih', '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>', { noremap = true, silent = true } }
    },
    [""] = {
        { 'leader>a', ':Tab /', { noremap = true } },
    }
}

utils.register_mappings(mappings, { noremap = true })
