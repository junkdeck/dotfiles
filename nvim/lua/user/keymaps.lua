-- keymap default common options
local opts = { noremap=true, silent=true}

-- remove search highlight
vim.keymap.set('n', '<leader>n', vim.cmd.nohlsearch)

-- basic diagnostic mappings
vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- fuzzy file finder keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Telescope: find files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Telescope: live grep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Telescope: find buffers" })

-- luasnip mappings for both INSERT and VISUAL
vim.keymap.set("i", "<C-n>", "<Plug>luasnip-next-choice", {})
vim.keymap.set("i", "<C-n>", "<Plug>luasnip-prev-choice", {})
vim.keymap.set("v", "<C-n>", "<Plug>luasnip-next-choice", {})
vim.keymap.set("v", "<C-n>", "<Plug>luasnip-prev-choice", {})

-- prettier mappings
vim.keymap.set('n', '<leader>p', "<Plug>(Prettier)", opts)
vim.keymap.set('v', '<leader>p', "<Plug>(PrettierFragment)", opts)


-- LSP mappings
-- only maps the following keys after
-- the language server attaches to the buffer
local on_attach = function(client, bufnr)
	-- enable completion <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- LSP mappings
	local bufopts= { noremap=true, silent=true, buffer=bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'gk', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async=true } end, bufopts)
end
