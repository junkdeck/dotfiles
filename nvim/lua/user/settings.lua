-- folding
vim.o.foldmethod = "indent"
vim.o.foldlevel = 99
-- line number display
vim.o.relativenumber = true
-- file reading and encoding
vim.o.autoread = true
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
-- only redraw screen when typing
vim.o.lazyredraw = true
-- search highlighting
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.scrolloff = 3
-- removes redundant mode display
vim.o.showmode = false
-- backspace behavior
vim.opt.backspace = {'indent', 'eol', 'start'}
-- case insensitive searching
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.tildeop = true
-- highlights cursor position
vim.o.cursorline = true
-- sets window title to current buffer name
vim.o.title = true
-- disable mouse control
vim.opt.mouse = {}

-- persistent per-file undo cache
vim.o.undofile = true

-- indentation
-- uses spaces instead of tabs
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

vim.cmd('colorscheme base16-gruvbox-light-soft')
