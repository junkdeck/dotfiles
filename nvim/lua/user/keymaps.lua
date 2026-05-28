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
vim.keymap.set("n", "<leader>fa", function()
    local stem = vim.fn.expand("%:t:r")
    -- drop trailing .spec / .test / _spec etc.
    stem = stem:gsub("[._]?[Ss]pec$", ""):gsub("[._]?[Tt]est$", "")
    builtin.find_files({ default_text = stem })
  end, { desc = "Telescope: find alternate files" })

-- luasnip mappings for both INSERT and VISUAL
vim.keymap.set("i", "<C-n>", "<Plug>luasnip-next-choice", {})
vim.keymap.set("i", "<C-n>", "<Plug>luasnip-prev-choice", {})
vim.keymap.set("v", "<C-n>", "<Plug>luasnip-next-choice", {})
vim.keymap.set("v", "<C-n>", "<Plug>luasnip-prev-choice", {})

-- vim-test mappings
vim.keymap.set('n', '<leader>tn', ":TestNearest<CR>", opts)
vim.keymap.set('n', '<leader>tf', ":TestFile<CR>", opts)
vim.keymap.set('n', '<leader>tl', ":TestLast<CR>", opts)

-- prettier mappings
vim.keymap.set('n', '<leader>p', "<Plug>(Prettier)", opts)
vim.keymap.set('v', '<leader>p', "<Plug>(PrettierFragment)", opts)

-- prevent * from jumping forward 
vim.keymap.set('n', '*', '*``')

-- sane terminal exit
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- close buffer instead of window (more compatible with mini.tabline)
vim.keymap.set('n', '<C-w>q', '<cmd>bd<CR>', opts)

-- set emmet key
vim.keymap.set({"n", "v"}, '<leader>e', require('nvim-emmet').wrap_with_abbreviation)
