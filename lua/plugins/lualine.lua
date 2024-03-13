return {
    'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
--    opts = {},
    config = function ()
        require('lualine').setup {
            options = {
                disabled_filetypes = {     -- Filetypes to disable lualine for.
                    statusline = {},       -- only ignores the ft for statusline.
                    winbar = {},           -- only ignores the ft for winbar.
                },
            },
            sections = {
                lualine_x = {'searchcount', 'fileformat', 'filesize', 'filetype'},
            }
        }
    end,
}
