return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer", -- source for text in buffer
            "hrsh7th/cmp-path", -- source for file system paths
            "L3MON4D3/LuaSnip", -- snippet engine
            "saadparwaiz1/cmp_luasnip", -- for autocompletion
            "rafamadriz/friendly-snippets", -- useful snippets
            "onsails/lspkind.nvim", -- vs-code like pictograms
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            {"antosha417/nvim-lsp-file-operations", config = true},
        },
        config = function()
            local lspconfig = require("lspconfig")
            --require'lspconfig'.pyright.setup{}
            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local keymap = vim.keymap -- for conciseness
            local opts = { noremap = true, silent = true }
            local on_attach = function(client, bufnr)
                opts.buffer = bufnr
                -- set keybinds
                opts.desc = "Show LSP references"
                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
                opts.desc = "Go to declaration"
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
                opts.desc = "Show LSP definitions"
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
                opts.desc = "Show LSP implementations"
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations
                opts.desc = "Show LSP type definitions"
                keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions
                opts.desc = "See available code actions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
                opts.desc = "Smart rename"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename
                opts.desc = "Show buffer diagnostics"
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
                opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
                opts.desc = "Go to previous diagnostic"
                keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
                opts.desc = "Go to next diagnostic"
                keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
                opts.desc = "Show documentation for what is under cursor"
                keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
            end
            -- used to enable autocompletion (assign to every lsp server config)
            local capabilities = cmp_nvim_lsp.default_capabilities()
            -- Change the Diagnostic symbols in the sign column (gutter)
            -- (not in youtube nvim video)
            local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end
            -- configure html server
            lspconfig["html"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            -- configure typescript server with plugin
            lspconfig["tsserver"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            -- configure css server
            lspconfig["cssls"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            -- configure python server
            lspconfig["pyright"].setup({
                --require("plugins.LSPs.pyright"),
                capabilities = capabilities,
                on_attach = on_attach,
            })
            -- configure lua server (with special settings)
            lspconfig["lua_ls"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = { -- custom settings for lua
                    Lua = {
                        -- make the language server recognize "vim" global
                        diagnostics = {
                            globals = {'vim'},
                        },
                        workspace = {
                        -- make language server aware of runtime files
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            },
                        },
                    },
                },
            })
        end,
    },

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        config = function()
            local lsp_zero = require('lsp-zero')
            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({
                    buffer = bufnr,
                    preserve_mappings = false
                })
            end)
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
            --require('mason').setup({})
            require('mason-lspconfig').setup({
            -- Replace the language servers listed here 
            -- with the ones you want to install
                ensure_installed = {
                    'tsserver',
                    "lua_ls",
                    "pyright",
                    "html",
                    "cssls",
                },
                handlers = {
                    lsp_zero.default_setup,
                    --local lsp_zero = require('lsp-zero'),
                    lsp_zero.on_attach(function(client, bufnr)
                        lsp_zero.default_keymaps({buffer = bufnr})
                    end),
                    require('mason').setup({}),
                    require('mason-lspconfig').setup({
                        ensure_installed = {'lua_ls'},
                        handlers = {lsp_zero.default_setup,},
                    }),
                    lsp_zero.default_setup,
                },
            })
            vim.api.nvim_create_user_command("InstallFormatters", function()
                local formatters = {
                    "isort",
                    "black",
                    "prettier",
                }
                for _, formatter in pairs(formatters) do
                    vim.cmd("MasonInstall " .. formatter)
                end
            end,
            {nargs = "*", desc = "Insta;; formatters through mason" })
            if vim.fn.executable("prettier") ~= 1 then
                vim.cmd("InstallFormatters")
            end
        end,
    },
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")
            local mason_tool_installer = require("mason-tool-installer")
            mason.setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
            mason_lspconfig.setup({
                ensure_installed = {
                    "tsserver",
                    "html",
                    "cssls",
                    "tailwindcss",
                    "svelte",
                    "lua_ls",
                    "graphql",
                    "emmet_ls",
                    "prismals",
                    "pyright",
                },
                automatic_installation = true, -- not the same as ensure_installed
            })
            mason_tool_installer.setup({
                ensure_installed = {
                    "prettier", -- prettier formatter
                    --"stylua", -- lua formatter
                    "isort", -- python formatter
                    "black", -- python formatter
                    "pylint", -- python linter
                    "eslint_d", -- js linter
                },
            })
        end,
    },

}
