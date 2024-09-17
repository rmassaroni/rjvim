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
            actions = {
                open_file = {
                    quit_on_open = true
                }
            },
            git = {
                enable = false
            }
        })

        -- vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>', {noremap = true})
    end
}
