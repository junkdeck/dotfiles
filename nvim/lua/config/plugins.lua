require('pckr').add{
	{
		'L3MON4D3/LuaSnip',
		tag = "v2.*",
		run = "make install_jsregexp"
	};

	-- LSP Integration
	'neovim/nvim-lspconfig';
	'hrsh7th/nvim-cmp';
	'hrsh7th/cmp-nvim-lsp';
	'hrsh7th/cmp-nvim-lsp-signature-help';
	'hrsh7th/cmp-buffer';
	'hrsh7th/cmp-path';

	-- Prettier
	{
		'prettier/vim-prettier',
		run = 'yarn install --frozen-lockfile --production',
		ft = {'javascript', 'typescript', 'css', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html' }
	}
}
