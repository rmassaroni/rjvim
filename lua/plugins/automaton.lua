return {
    "eandrju/cellular-automaton.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
    vim.keymap.set('n', '<leader>c',':CellularAutomaton make_it_rain<CR>', {noremap = true})
}
