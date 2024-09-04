--might not need this plugin if i already have mason
return {
    "folke/neodev.nvim",
    opts = {},
    config = function ()
        require("neodev").setup({})
    end
}
