return {
    "goolord/alpha-nvim",
    event = "VimEnter", -- correct cursor position
    config = function()
        require'alpha'.setup {
            layout = require'plugins.alpha.layout'
        }
    end
}
