return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {"nvim-tree/nvim-web-devicons"},
    opts = {},

    vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>', {noremap = true}),
    vim.keymap.set('n', '<A-t>', ':NvimTreeOpen<CR>', {noremap = true}),
}
