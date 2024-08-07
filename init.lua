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

-- vim.g.closetag_enable_react_fragment = 1

vim.diagnostic.config({virtual_text=false})



vim.api.nvim_set_keymap('n', '<leader>y', 'ggVG"+y', { noremap = true, silent = true })

vim.opt.clipboard:append("unnamedplus")

-- local function format_pasted_text()
--     local last_cursor_position = vim.fn.getpos(".")
--     vim.cmd("normal! `[v`]")
--     vim.cmd("normal! =")
--     vim.fn.setpos('.', last_cursor_position)
-- end
--
-- vim.api.nvim_create_autocmd("TextYankPost", {
--     callback = function()
--         if vim.v.event.operator == 'y' then
--             format_pasted_text()
--         end
--     end,
-- })

-------LAZY SETUP
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

require'nvim-treesitter.configs'.setup {
    auto_install = true,
  --ensure_installed = 'all', -- Install all available parsers
  highlight = {
    enable = true, -- Enable Treesitter's syntax highlighting
  },
  incremental_selection = {
    enable = true, -- Enable Treesitter's incremental selection
  },
  -- Disable other parsers
  parser = {
    enabled = { 'treesitter' }, -- Only enable the Treesitter parser
    disable_other = true, -- Disable all other parsers
  },
}

