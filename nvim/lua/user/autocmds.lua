-- only show relative line numbers in active window and normal mode
local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
  group = numbertoggle,
  pattern = "*",
  callback = function() 
    vim.opt.relativenumber = true 
    vim.opt.number = false
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
  group = numbertoggle,
  pattern = "*",
  callback = function() 
    vim.opt.relativenumber = false 
    vim.opt.number = true
  end,
})
