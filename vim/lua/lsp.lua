-- lsp.lua
local utils = require('utils')
local cmp = require('cmp')

cmp.setup({
	mapping = {
		["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if #cmp.get_entries() == 1 then
					cmp.confirm({ select = true })
				else
					cmp.select_next_item()
				end
			elseif utils.CheckBackspace() then
				cmp.complete()
				if #cmp.get_entries() == 1 then
					cmp.confirm({ select = true })
				end
			else
				fallback()
			end
		end, { "i", "s" }),
		['<DOWN>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if #cmp.get_entries() == 1 then
					cmp.confirm({ select = true })
				else
					cmp.select_next_item()
				end
			elseif utils.CheckBackspace() then
				cmp.complete()
				if #cmp.get_entries() == 1 then
					cmp.confirm({ select = true })
				end
			else
				fallback()
			end
		end, { "i", "s" }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
            else
                fallback()
			end
		end, { "i", "s" }),
		['<UP>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
            else
                fallback()
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
	}, {
		{ name = 'buffer' },
	})
})

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

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- CLANGD
require('lspconfig').clangd.setup({
    name = 'clangd',
    cmd = {'clangd-15'}, --, '--background-index', '--enable-config', '-j=14', '--log=info', '--pretty', '--limit-results=0', '--limit-references=0'},
	capabilities = capabilities,
    filetypes = {'c', 'cc', 'cpp', 'h', 'hh', 'hpp', 'proto'},
    root_dir = require('lspconfig').util.root_pattern('compile_commands.json'),
})

-- GOPLS
require('lspconfig').gopls.setup({
    name = 'gopls',
	cmd = {'gopls'},
	capabilities = capabilities,
    filetypes = {'go'},
    root_dir = require('lspconfig').util.root_pattern('go.mod', 'go.sum', 'go.work', '.git'),
	settings = {
		gopls = {
			experimentalPostfixCompletions = true,
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
		},
	},
	init_options = {
		usePlaceholders = true,
	}
})
