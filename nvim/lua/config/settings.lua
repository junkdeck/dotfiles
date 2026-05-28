-- plugin setup and settings
-- initialize lualine
require('lualine').setup()


-- initialize tabline (tabs)
require('mini.tabline').setup()

-- initialize and install required treesitter plugins
-- already installed plugins will be skipped
require('nvim-treesitter').install({ 'lua', 'luadoc', 'vim', 'vimdoc', 'javascript', 'vue', 'ruby', 'typescript', 'tsx'})
vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'lua', 'luadoc', 'vim', 'vimdoc', 'javascript', 'vue', 'ruby', 'typescript', 'tsx' },
        callback = function() vim.treesitter.start() end
});

-- setup and start telescope
-- use native fzf instead of bogus fzy algo
require('telescope').setup({
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
})
require('telescope').load_extension('fzf')

