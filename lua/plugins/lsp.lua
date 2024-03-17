return {
    {
        --"github/copilot.vim" --not working
    },
    {
        --might not need this plugin if i already have mason
       "folke/neodev.nvim",
        opts = {},
        config = function ()
            require("neodev").setup({
                -- add any options here, or leave empty to use the default settings
            })
        end,
    },
    {
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
        end,
    },
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
            --{"antosha417/nvim-lsp-file-operations", config = true},--???
        },
        config = function ()
            local lspconfig = require("lspconfig")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local opts = {noremap = true, silent = true}
            local on_attach = function(client, bufnr)
                opts.buffer = bufnr
            end
            local capabilities = cmp_nvim_lsp.default_capabilities()
            local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end
            lspconfig["lua_ls"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        diagnostics = {globals = {'vim'}},
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            },
                        },
                    },
                },
            })
            lspconfig["html"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig["pyright"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig["cssls"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig["jdtls"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig["tsserver"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig["clangd"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig["sqls"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig["kotlin_language_server"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })


        end,
    },
    {
        --"mfussenegger/nvim-jdtls",
        --config = function ()
        --    local config = {
        --        cmd = {'/home/rjm/.local/bin/jdtls'},
        --        root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
        --    }
        --    require('jdtls').start_or_attach(config)
        --end,
    },
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer", -- source for text in buffer
            "hrsh7th/cmp-path", -- source for file system paths
            "L3MON4D3/LuaSnip", -- snippet engine
            "saadparwaiz1/cmp_luasnip", -- for autocompletion
            "rafamadriz/friendly-snippets", -- useful snippets
            "onsails/lspkind.nvim", -- vs-code like pictograms
        },
        config = function()
            local cmp = require('cmp')

            local luasnip = require("luasnip") --?
            local lspkind = require("lspkind") --?
            require("luasnip.loaders.from_vscode").lazy_load() --?


            --local cmp_action = require('lsp-zero').cmp_action()

            cmp.setup({
                completion = {--is this and snippet necessary?
                    completeopt = "menu,menuone,preview,noselect",
                },
                snippet = { -- configure how nvim-cmp interacts with snippet engine
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    -- `Enter` key to confirm completion
                    ['<CR>'] = cmp.mapping.confirm({select = false}),
                    -- Ctrl+Space to trigger completion menu
                    ['<C-Space>'] = cmp.mapping.complete(),
                    -- Navigate between snippet placeholder
                    --['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    --['<C-b>'] = cmp_action.luasnip_jump_backward(),
                    -- Scroll up and down in the completion documentation
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                }),
                --sources and formatting necessary?
                -- sources for autocompletion
                sources = cmp.config.sources({
                    {name = "nvim_lsp"},
                    {name = "luasnip"}, -- snippets
                    {name = "buffer"}, -- text within current buffer
                    {name = "path"}, -- file system paths
                }),
                -- configure lspkind for vs-code like pictograms in completion menu
                formatting = {
                    format = lspkind.cmp_format({
                        maxwidth = 50,
                        ellipsis_char = "...",
                    }),
                },
            })
        end,
    }
}
