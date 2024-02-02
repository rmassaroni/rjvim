return {
    {
        'williamboman/mason.nvim',
        --dependencies = {
        --    "williamboman/mason-lspconfig.nvim",
        --    "WhoIsSethDaniel/mason-tool-installer.nvim", --???????
        --},
    },
    {"williamboman/mason-lspconfig.nvim"},
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        --lazy = true, --????
        --config = false, --??????
        config = function()
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            local cmp_nvim_lsp = require("cmp_nvim_lsp") --?
            local keymap = vim.keymap --for conciseness
            local opts = {noremap = true, silent = true} --?
            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                --lsp_zero.default_keymaps({
                --    buffer = bufnr,
                --    --preserve_mappings = false --?????????
                --})

                --the following of this function is from the on_attach function of an old lspconfig
                opts.buffer = bufnr


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

            end)

            local capabilities = cmp_nvim_lsp.default_capabilities()
            -- Change the Diagnostic symbols in the sign column (gutter)
            -- (not in youtube nvim video)
            local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end


            --mason
            require('mason').setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'tsserver',
                    "lua_ls",
                    "pyright",
                    "html",
                    "cssls",
                },
                automatic_installation = true, --????
                handlers = {
                    lsp_zero.default_setup,
                    --example_server = function()
                    --    require('lspconfig').example_server.setup({
                    --        ---
                    --        -- in here you can add your own
                    --        -- custom configuration
                    --        ---
                    --    })
                    --end,
                    lua_ls = function()
                        require('lspconfig').lua_ls.setup({
                            lsp_zero.nvim_lua_ls(),  --??????
                            settings = { -- custom settings for lua
                                Lua = {
                                    -- make the language server recognize "vim" global
                                    diagnostics = {
                                        globals = {'vim'},--and client?
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
                    pyright = function()
                        require('lspconfig').pyright.setup({
                            --capabilities = capabilities,
                            --on_attach = on_attach,
                        })
                    end,
                    html = function()
                        require('lspconfig').html.setup({})
                    end,
                    tsserver = function()
                        require('lspconfig').tsserver.setup({})
                    end,
                    cssls = function()
                        require('lspconfig').cssls.setup({})
                    end,
                },
            })

            --formatters
            vim.api.nvim_create_user_command("InstallFormatters", function()
                local formatters = {
                    "isort",
                    "black",
                    "prettier",
                    --"sty_lua",
                    --"pylint",
                    --"eslint",
                }
                for _, formatter in pairs(formatters) do
                    vim.cmd("MasonInstall " .. formatter)
                end
            end,
            {nargs = "*", desc = "Insta;; formatters through mason" })
            if vim.fn.executable("prettier") ~= 1 then
                vim.cmd("InstallFormatters")
            end
            --mason tool installer?????
        end,
    },
    {
        'neovim/nvim-lspconfig',
        --event = { "BufReadPre", "BufNewFile" },--????
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
            {"antosha417/nvim-lsp-file-operations", config = true},--???
        },
        --opts = {
            --signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " },
        --}
    },
      -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter", --???
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


            local cmp_action = require('lsp-zero').cmp_action()

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
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
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
    },
}


