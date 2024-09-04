return  {
    'williamboman/mason.nvim',
    dependencies = {
        "nvim-lua/plenary.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function ()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")
        mason.setup({
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })
        mason_lspconfig.setup({
            ensure_installed = {
                'tsserver',
                "lua_ls",
                "pyright",
                "html",
                "cssls",
                "jdtls",
                "clangd",
                "sqls",
                "kotlin_language_server"
            },
            automatic_installation = true,
        })
        mason_tool_installer.setup({
            ensure_installed = {
                "prettier", -- prettier formatter
                "stylua", -- lua formatter
                "isort", -- python formatter
                "black", -- python formatter
                "pylint", -- python linter
                "eslint_d", -- js linter
            }
        })
    end
}
