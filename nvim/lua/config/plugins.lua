require('pckr').add{
  -- libraries
  'nvim-lua/plenary.nvim';
  'nvim-tree/nvim-web-devicons';
  'lewis6991/gitsigns.nvim';

  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate'
  };

  -- tabs
  {
    'nvim-mini/mini.tabline',
    version = "*" ,
  };


  -- fuzzy finder / file navigation
  'chrisgrieser/nvim-genghis';
  'nvim-telescope/telescope.nvim';
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make' 
  };

  -- statusline
  'nvim-lualine/lualine.nvim';


  -- input utilities
  'tpope/vim-unimpaired';
  'chaoren/vim-wordmotion';
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

  -- emmet
  'olrtg/nvim-emmet';

  -- web-development
  'tpope/vim-rails';

  -- testing
  'janko/vim-test';

  -- highlighting / colorschemes
  'RRethy/base16-nvim';
  'ellisonleao/gruvbox.nvim';

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

