require('gruvbox').setup({
  terminal_colors = true,
  contrast = "soft",
  dim_inactive = true,
  -- transparent_mode = true,
  inverse = true,
})

vim.o.background = "dark"
vim.opt.termguicolors = true;
vim.cmd("colorscheme gruvbox")
