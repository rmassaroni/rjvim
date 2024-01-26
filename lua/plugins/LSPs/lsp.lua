local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({
        buffer = bufnr,
        preserve_mappings = false -- Needed to force the default mappings
    })
    lsp_zero.buffer_autoformat()  -- TODO Is this needed after adding conform?
end)

-- Get the language server to recognize the `vim` global in Neovim config
local lua_opts = lsp_zero.nvim_lua_ls()
require("lspconfig").lua_ls.setup(lua_opts)

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",   -- Lua
        "pyright",  -- Python

        "tsserver", -- JavaScript / TypeScript
        "html",     -- HTML
        "cssls",    -- CSS
    },
    handlers = {local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here 
  -- with the ones you want to install
  ensure_installed = {'tsserver', 'rust_analyzer'},
  handlers = {
    lsp_zero.default_setup,
  },
})
        -- Sets up servers with default settings
        lsp_zero.default_setup,
    },
})

-- Custom function to install formatters (prettier)
vim.api.nvim_create_user_command("InstallFormatters", function()
    local formatters = {
        "isort",
        "black",
        "prettier",
    }

    for _, formatter in pairs(formatters) do
        vim.cmd("MasonInstall " .. formatter)
    end
end, { nargs = "*", desc = "Install formatters through mason" })

-- If prettier is not installed, install formatters
if vim.fn.executable("prettier") ~= 1 then
    vim.cmd("InstallFormatters")
end
