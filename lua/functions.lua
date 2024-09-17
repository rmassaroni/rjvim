local M = {}

-- function ToggleVirtualText()
-- M.toggle_virtual_text = function()
M.ToggleVirtualText = function()
    local current_config = vim.diagnostic.config()
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

return M
