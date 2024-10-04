local alpha = require('alpha')
local lazy = require('lazy')
local mason = require('mason')

-- local function get_plugin_status()
--     local status = {}
--     for name, plugin in pairs(lazy.plugins) do
--         local plugin_status = plugin.is_loaded and "✔️ Loaded" or "❌ Not Loaded"
--         table.insert(status, name .. ": " .. plugin_status)
--     end
--     return status
-- end

-- local function get_lsp_status()
--     local lsp_status = {}
--     for _, server in pairs(mason.get_installed_servers()) do
--         local status = vim.lsp.get_active_clients({ name = server.name })[1] and "✔️ Active" or "❌ Inactive"
--         table.insert(lsp_status, server.name .. ": " .. status)
--     end
--     return lsp_status
-- end

-- local function get_health_stats()
--     local health_report = {}
--     -- local health_info = vim.fn.health#check()  -- Use vim.fn.health for health check
--     -- if health_info == 0 then
--     --     table.insert(health_report, "Health check passed!")
--     -- else
--     --     table.insert(health_report, "Health check failed!")
--     -- end
--     return health_report
-- end

local function get_system_info()
    local os_info = vim.loop.os_uname().sysname .. " " .. vim.loop.os_uname().release
    return { "OS: " .. os_info, "Neovim Version: " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch }
end

local function layout()
    return {
        { type = "text", val = "Plugin Status", opts = { hl = "AlphaCol1", position = "center" }},
        -- { type = "text", val = get_plugin_status(), opts = { hl = "AlphaCol2", position = "center" }},
        { type = "padding", val = 1 },
        { type = "text", val = "LSP Status", opts = { hl = "AlphaCol1", position = "center" }},
        -- { type = "text", val = get_lsp_status(), opts = { hl = "AlphaCol2", position = "center" }},
        { type = "padding", val = 1 },
        { type = "text", val = "Health Status", opts = { hl = "AlphaCol1", position = "center" }},
        -- { type = "text", val = get_health_stats(), opts = { hl = "AlphaCol2", position = "center" }},
        { type = "padding", val = 1 },
        { type = "text", val = "System Information", opts = { hl = "AlphaCol1", position = "center" }},
        { type = "text", val = get_system_info(), opts = { hl = "AlphaCol2", position = "center" }},
    }
end

return layout()

