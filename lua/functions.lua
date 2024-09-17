local M = {}

M.ToggleVirtualText = function()
    local current_config = vim.diagnostic.config() or {}
    local new_virtual_text_state = not current_config.virtual_text

    vim.diagnostic.config({
        virtual_text = new_virtual_text_state
    })

    if new_virtual_text_state then
        print("Virtual text enabled")
    else
        print("Virtual text disabled")
    end
end

-- function -> user command automation
for name, func in pairs(M) do
    if type(func) == "function" then
        vim.api.nvim_create_user_command(name:gsub("^%l", string.upper), func, {})
    end
end

return M
