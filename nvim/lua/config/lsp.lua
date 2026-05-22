-- advertise nvim-cmp to LSP servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- enable snippet support for css,html,etc
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- activate LSPs
-- IMPORTANT: LSPs must be installed manually via NPM!
local servers  = {'tailwindcss', 'tsserver', 'jsonls', 'eslint'}

for _, lsp in pairs(servers) do
	vim.lsp.config[lsp] = {
		on_attach = on_attach,
		capabilities = capabilities;
	}
	vim.lsp.enable(lsp)
end

vim.lsp.config['html'] = {
	on_attach = on_attach,
	capabilities = capabilities
}

vim.lsp.config['cssls'] = {
	on_attach = on_attach,
	capabilities = capabilities
}

vim.lsp.config['emmet-ls'] = {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue"},
	init_options = {
		html = {
			options = {
				['bem.enabled'] = true,
			}
		}
	}
}

-- snippet setup
local luasnip = require("luasnip")
require("luasnip.loaders.from_lua").lazy_load()

-- required for nvim-cmp tab mapping
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- CMP - autocompletion setup
local cmp = require('cmp')
cmp.setup {
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end;
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end,
		{ "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end,
		{ "i", "s" }),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'luasnip' },
		{ name = 'buffer' },
		{ name = 'path' }
	},
}
