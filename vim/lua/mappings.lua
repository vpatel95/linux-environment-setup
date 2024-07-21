-- Mappings
local fn = vim.fn
local cmd = vim.cmd

local function register_mappings(mappings, default_options)
    for mode, mode_mappings in pairs(mappings) do
        for _, mapping in pairs(mode_mappings) do
            local options = #mapping == 3 and table.remove(mapping) or default_options
            local prefix, cmd = unpack(mapping)
            pcall(vim.api.nvim_set_keymap, mode, prefix, cmd, options)
        end
    end
end

function _G.CheckBackspace()
    local col = fn.col('.') - 1
    if col == 0 or fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

function _G.show_documentation()
    local cw = fn.expand('<cword>')
    if fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
        cmd('h ' .. cw)
    elseif api.nvim_eval('coc#rpc#ready()') then
        fn.CocActionAsync('doHover')
    else
        cmd('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

cmd([[
    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
]])

local mappings = {
    ["i"] = {
        {
            '<TAB>',
            'coc#pum#visible() ? coc#pum#next(1) : v:lua.CheckBackspace() ? "<TAB>" : coc#refresh()',
            { noremap = true, expr = true, silent = true}
        },
        {
            '<UP>',
            'coc#pum#visible() ? coc#pum#prev(1) : "<UP>"',
            { noremap = true, expr = true, silent = true }
        },
        {
            '<DOWN>',
            'coc#pum#visible() ? coc#pum#next(1) : "<DOWN>"',
            { noremap = true, expr = true, silent = true }
        },
        {
            '<CR>',
            'coc#pum#visible() ? coc#pum#confirm() : "<C-g>u<CR><c-r>=coc#on_enter()<CR>"',
            { noremap = true, expr = true, silent = true }
        },

        { '<leader>ci', ':set cindent<CR>' },
        { '<C-f>', '<cmd>lua require("utils").find_files()<CR>', { noremap = true, silent = true } },
        { '<leader>fb', '<cmd>FzfLua buffers<CR>', {noremap = true, silent = true } },
        { '<leader>fg', '<cmd>FzfLua live_grep<CR>', {noremap = true, silent = true } },
        { '<leader>gc', '<cmd>FzfLua git_branches<CR>', {noremap = true, silent = true } },
        { '<leader>gs', '<cmd>FzfLua git_stash<CR>', {noremap = true, silent = true } },
        { '<leader>fw', ':Ag<CR>' },

        { '<C-space>', 'coc#refresh()', { noremap = true, silent = true, expr = true } },
        { '<leader>ih', '<cmd>CocCommand document.toggleInlayHint<CR>', { noremap = true, silent = true } }
    },
    ["n"] = {
        { '<C-L>', ':silent! nohl<CR><C-L>', { noremap = true, silent = true } },
        { '<leader>d', ':silent! NvimTreeToggle<CR>', { noremap = true, silent = true } },
        { '<leader>s', ':silent! TagbarToggle<CR>', { noremap = true, silent = true } },
        { '<leader>g', ':silent! GundoToggle<CR>', { noremap = true, silent = true } },

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
        { '<leader>1', '1gt' },
        { '<leader>2', '2gt' },
        { '<leader>3', '3gt' },
        { '<leader>4', '4gt' },
        { '<leader>5', '5gt' },
        { '<leader>6', '6gt' },
        { '<leader>7', '7gt' },
        { '<leader>8', '8gt' },
        { '<leader>9', '9gt' },

        { '<leader>mc', ':set mouse=c<CR>' },
        { '<leader>ma', ':set mouse=a<CR>' },

        { '<leader>cws', ':%s/\\s\\+$//e<CR>' },

        { '<leader>ci', ':set cindent<CR>' },

        { '<leader>fw', ':Ag<CR>' },
        { '<C-f>', '<cmd>lua require("utils").find_files()<CR>', { noremap = true, silent = true } },
        { '<leader>fb', '<cmd>FzfLua buffers<CR>', {noremap = true, silent = true } },
        { '<leader>fg', '<cmd>FzfLua live_grep<CR>', {noremap = true, silent = true } },
        { '<leader>gc', '<cmd>FzfLua git_branches<CR>', {noremap = true, silent = true } },
        { '<leader>gs', '<cmd>FzfLua git_stash<CR>', {noremap = true, silent = true } },
        { '<leader>f', ':Ack! <C-R>=expand("<cword>")<CR><CR>', { noremap = true } },

        { '[c', '<Plug>(coc-diagnostic-prev)', { silent = true } },
        { ']c', '<Plug>(coc-diagnostic-next)', { silent = true } },
        { 'gd', ':call CocAction(\'jumpDefinition\')<CR>', { silent = true } },
        { 'vd', ':call CocAction(\'jumpDefinition\', \'vsplit\')<CR>', { silent = true } },
        { 'sd', ':call CocAction(\'jumpDefinition\', \'split\')<CR>', { silent = true } },
        { 'gg', ':call CocAction(\'jumpDeclaration\')<CR>', { silent = true } },
        { 'vg', ':call CocAction(\'jumpDeclaration\', \'vsplit\')<CR>', { silent = true } },
        { 'sg', ':call CocAction(\'jumpDeclaration\', \'split\')<CR>', { silent = true } },
        { 'gt', ':call CocAction(\'jumpTypeDefinition\')<CR>', { silent = true } },
        { 'vt', ':call CocAction(\'jumpTypeDefinition\', \'vsplit\')<CR>', { silent = true } },
        { 'st', ':call CocAction(\'jumpTypeDefinition\', \'split\')<CR>', { silent = true } },
        { 'gr', ':call CocAction(\'jumpUsed\')<CR>', { silent = true } },
        { 'vr', ':call CocAction(\'jumpUsed\', \'vsplit\')<CR>', { silent = true } },
        { 'sr', ':call CocAction(\'jumpUsed\', \'split\')<CR>', { silent = true } },
        { 'hd', ':call CocAction(\'definitionHover\')<CR>', { silent = true } },
        { 'cg', ':call CocAction(\'showIncomingCalls\')<CR>', {silent = true } },
        { 'suh', ':call CocAction(\'showSuperTypes\')<CR>', {silent = true } },
        { 'sbh', ':call CocAction(\'showSubTypes\')<CR>', {silent = true } },

        { '<space>a', ':<C-u>CocList diagnostics<CR>', { noremap = true, silent = true, nowait = true } },
        { '<space>e', ':<C-u>CocList extensions<CR>', { noremap = true, silent = true, nowait = true } },
        { '<space>c', ':<C-u>CocList commands<CR>', { noremap = true, silent = true, nowait = true } },
        { '<space>o', ':<C-u>CocList outline<CR>', { noremap = true, silent = true, nowait = true } },
        { '<space>s', ':<C-u>CocList symbols<CR>', { noremap = true, silent = true, nowait = true } },
        { '<space>j', ':<C-u>CocNext<CR>', { noremap = true, silent = true, nowait = true } },
        { '<space>k', ':<C-u>CocPrev<CR>', { noremap = true, silent = true, nowait = true } },
        { '<space>p', ':<C-u>CocListResume<CR>', { noremap = true, silent = true, nowait = true } },

        { '<space>w', ':<C-u>MatchupWhereAmI?<CR>', { noremap = true, silent = true, nowait = true } },
        { '<leader>ih', '<cmd>CocCommand document.toggleInlayHint<CR>', { noremap = true, silent = true } }
    },
    [""] = {
        { 'leader>a', ':Tab /', { noremap = true } },
        { '<leader>ih', '<cmd>CocCommand document.toggleInlayHint<CR>', { noremap = true, silent = true } }
    }
}

register_mappings(mappings, { noremap = true })
