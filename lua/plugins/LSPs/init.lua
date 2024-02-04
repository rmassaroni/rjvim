return {
    {'williamboman/mason.nvim'},
    {"williamboman/mason-lspconfig.nvim"},
    require("plugins.LSPs.lspzero"),
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
            {"antosha417/nvim-lsp-file-operations", config = true},--???
        },
    },
    require("plugins.LSPs.cmp")
}

