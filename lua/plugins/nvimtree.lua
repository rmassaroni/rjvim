return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {"nvim-tree/nvim-web-devicons"},

    config = function ()
        require('nvim-tree').setup({
            view = {
                width = 30,
            },
        })
    end,


    vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>', {noremap = true}),
    vim.keymap.set('n', '<A-t>', ':NvimTreeOpen<CR>', {noremap = true}),
    --vim.cmd[[autocmd BufEnter * if winnr('$') == 1 and vim.api.nvim_buf_get_var(0, 'NERDTree') and vim.api.nvim_buf_get_var(0, 'NERDTree'):isTabTree() then vim.cmd('q') end]]

}
