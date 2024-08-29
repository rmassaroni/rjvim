vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.clipboard:append("unnamedplus")

vim.diagnostic.config({virtual_text=false})

vim.api.nvim_set_keymap('n', '<leader>y', 'ggVG"+y', { noremap = true, silent = true })


-------LAZY SETUP

