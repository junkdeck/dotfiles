-- plugin setup and settings
require('lualine').setup()

require('nvim-treesitter').install({ 'lua', 'luadoc', 'vim', 'vimdoc', 'javascript', 'vue', 'ruby', 'typescript', 'tsx'})

vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'lua', 'luadoc', 'vim', 'vimdoc', 'javascript', 'vue', 'ruby' },
        callback = function() vim.treesitter.start() end
});

vim.cmd('colorscheme base16-gruvbox-light-soft')

