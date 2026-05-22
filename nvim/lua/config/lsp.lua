-- advertise nvim-cmp to LSP servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- enable snippet support for css,html,etc
capabilities.textDocument.completion.completionItem.snippetSupport = true
--
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

-- activate LSPs
-- IMPORTANT: LSPs must be installed manually via NPM!
local servers  = {'tailwindcss', 'jsonls', 'eslint', 'html', 'cssls', 'vue_ls'}

for _, lsp in pairs(servers) do
	vim.lsp.config[lsp] = {
		on_attach = on_attach,
		capabilities = capabilities;
	}
	vim.lsp.enable(lsp)
end

vim.lsp.config['emmet_ls'] = {
	-- on_attach = on_attach,
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
vim.lsp.enable('emmet_ls')

local npm_root = vim.fn.trim(vim.fn.system('npm root -g'))
local vue_ts_plugin = npm_root .. '/@vue/language-server/node_modules/@vue/typescript-plugin'

vim.lsp.config['ts_ls'] = {
  capabilities = capabilities,
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = vue_ts_plugin,
        languages = { 'vue' },
      },
    },
  },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
}
vim.lsp.enable('ts_ls')

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
