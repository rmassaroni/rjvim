function display_neofetch()
    local handle = io.popen('neofetch')
    local result = handle:read('*a')
    handle:close()

    vim.cmd('new')
    vim.cmd('setlocal buftype=nofile')
    vim.cmd('setlocal bufhidden=wipe')
    vim.cmd('setlocal noswapfile')
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(result, '\n'))
end

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        display_neofetch()
    end
})

