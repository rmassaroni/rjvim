return {
    'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
--    opts = {},
    config = function ()
        require('lualine').setup {
            sections = {
                lualine_x = {'searchcount', 'fileformat', 'filesize', 'filetype'},
            }
        }
    end,
}
