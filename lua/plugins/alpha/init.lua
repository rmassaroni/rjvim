return {
    "goolord/alpha-nvim",
    event = "VimEnter", -- correct cursor position
    config = function()
        -- require'alpha'.setup {
            -- layout = require'plugins.alpha.pages.onepage'
        -- }
        -- require'alpha'.setup(require'plugins.alpha.layout')() -- one-liner not working
        require('plugins.alpha.pages.pages')
    end
}
