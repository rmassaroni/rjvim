return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    require("plugins/LSPs/nvim-cmp"),

    config = function ()
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

        require('mason').setup({})
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
    end
}

