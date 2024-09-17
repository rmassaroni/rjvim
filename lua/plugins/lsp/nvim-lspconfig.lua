return {
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
        -- lspconfig["tsserver"].setup({
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        --     init_options = {
        --         lint = {
        --             unusedVariable = "none" -- Suppress unused variable warnings
        --         }
        --     },
        --     settings = {
        --         javascript = {
        --             suggest = {
        --                 names = true,
        --                 paths = true
        --             },
        --             validate = {
        --                 enable = true
        --             },
        --             preferences = {
        --                 importModuleSpecifierPreference = "relative"
        --             }
        --         },
        --         typescript = {
        --             suggest = {
        --                 names = true,
        --                 paths = true
        --             },
        --             validate = {
        --                 enable = true
        --             },
        --             preferences = {
        --                 importModuleSpecifierPreference = "relative"
        --             }
        --         }
        --     }
        -- })
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
            root_dir = function(fname)
                local root_files = {
                    'settings.gradle', -- Gradle (multi-project)
                    'settings.gradle.kts', -- Gradle (multi-project)
                    'build.xml', -- Ant
                    'pom.xml', -- Maven
                }

                local fallback_root_files = {
                    'build.gradle', -- Gradle
                    'build.gradle.kts', -- Gradle
                }

                local primary = require'lspconfig'.util.root_pattern(unpack(root_files))(fname)
                local fallback = require'lspconfig'.util.root_pattern(unpack(fallback_root_files))(fname)
                return primary or fallback
            end

        })
        -- lspconfig["eslint_d"].setup({
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        --
        -- })
        lspconfig['gopls'].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lspconfig['rust_analyzer'].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end
}
