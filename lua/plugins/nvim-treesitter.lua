return {
    'nvim-treesitter/nvim-treesitter',
    config = function ()
        require'nvim-treesitter.configs'.setup {
            auto_install = true,
            highlight = {
                enable = true
            },
            incremental_selection = {
                enable = true
            },
            parser = {
                enabled = { 'treesitter' },
                disable_other = true
            }
        }
    end
}
