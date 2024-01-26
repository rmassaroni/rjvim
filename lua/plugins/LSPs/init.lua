return {
    {
        --require("plugins/LSPs/lsp"),
    },
    {
    --mason-lspconfig.nvim
--    require("plugins/LSPs/lspzero"),
    --"williamboman/mason.nvim",
--    require("plugins/LSPs/mason"),
    --"williamboman/mason-lspconfig.nvim",
    --"neovim/nvim-lspconfig",
--    require("plugins/LSPs/lspconfig"),
    },


--[[
    {require("plugins.LSPs.lspzero")},
	{
--        'neovim/nvim-lspconfig',
--        config = function()
--            require "lspconfig"
--            require'lspconfig'.pyright.setup{}
--            require'lspconfig'.lua_ls.setup{}
--        end,
    },
    {require("plugins/LSPs/lspconfig")},
    --{'hrsh7th/cmp-nvim-lsp'},
	--{'hrsh7th/nvim-cmp'},
	--{'L3MON4D3/LuaSnip'},
    {require("plugins/LSPs/nvim-cmp")},
    {require("plugins/LSPs/mason")},


    --]]
    --
    require("plugins.LSPs.newlsp")
}

