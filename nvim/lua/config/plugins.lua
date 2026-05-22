require('pckr').add{
	-- libraries
	'nvim-lua/plenary.nvim';
	'nvim-tree/nvim-web-devicons';
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate'
	};

	-- testing
	'janko/vim-test';

	-- fuzzy finder / file navigation
	'chrisgrieser/nvim-genghis';
	'nvim-telescope/telescope.nvim';
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install' 
	};

	-- statusline
	'nvim-lualine/lualine.nvim';

	-- input utilities
	{
		'kylechui/nvim-surround',
		version = "^4.0.0"
	};
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = function() 
			require("nvim-autopairs").setup()
		end
	};

	-- web-development
	'tpope/vim-rails';
	'aca/emmet-ls';

  -- highlighting / colorschemes
  'RRethy/base16-nvim';

	-- LSP Integration
	'neovim/nvim-lspconfig';
	'hrsh7th/nvim-cmp';
	'hrsh7th/cmp-nvim-lsp';
	'hrsh7th/cmp-nvim-lsp-signature-help';
	'hrsh7th/cmp-buffer';
	'hrsh7th/cmp-path';

	{
		'prettier/vim-prettier',
		run = 'yarn install --frozen-lockfile --production',
		ft = {'javascript', 'typescript', 'css', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html' }
	};

	{
		'L3MON4D3/LuaSnip',
		tag = "v2.*",
		run = "make install_jsregexp"
	};
}

-- optional plugin configuration
require('lualine').setup()

require('nvim-treesitter').install({ 'lua', 'luadoc', 'vim', 'vimdoc', 'javascript', 'vue', 'ruby'})
vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'lua', 'luadoc', 'vim', 'vimdoc', 'javascript', 'vue', 'ruby' },
        callback = function() vim.treesitter.start() end
});

