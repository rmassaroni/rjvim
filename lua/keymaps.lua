--copies file to clipboard
vim.api.nvim_set_keymap('n', '<leader>y', 'ggVG"+y', { noremap = true, silent = true })

--toggles virtual text
vim.api.nvim_set_keymap('n', '<leader>v', ':ToggleVirtualText<CR>', { noremap = true, silent = true })
