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



ColorCount = 1
TabString = ""
function ToggleColorScheme()
    ColorCount = ColorCount + 1
    --print(ColorCount)
    local s = "<Tab>"
    for i = 1, ColorCount, 1
    do
        s = s .. "<Tab>"
    end
    print(s)
    TabString = s
    return s
end

vim.keymap.set('n', '<leader>g', ':colorscheme ' .. ToggleColorScheme(), {noremap = true})


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    spec = {import = "plugins"},
    ui = {
        border = "double",
        size = {
            width = 0.8,
            height = 0.8,
        },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {notify = false},
})
