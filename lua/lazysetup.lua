--local lazypath = "C:\\Program Files\\nvim-win64\\bin\\lazy.nvim"
-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local is_windows = vim.loop.os_uname().version:match("Windows")
local lazypath

if is_windows then
  lazypath = "C:\\Program Files\\nvim-win64\\bin\\lazy.nvim"
else
  lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
end

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {import = "plugins"},
    ui = {
        border = "double",
        size = {
            width = 0.8,
            height = 0.8
        }
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {notify = false}
})
