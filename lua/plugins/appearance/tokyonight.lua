return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {transparent = true},
    transparent = true,
    config = function ()
        require("tokyonight").setup {
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            }
        }
        vim.cmd([[colorscheme tokyonight-moon]])
    end,
    --vim.keymap.set('n', '<leader>s', )
}
