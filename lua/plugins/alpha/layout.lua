local lazycache = require('plugins.alpha.lazycache')
local buttons = require('plugins.alpha.buttons')
local asciiheader = require('plugins.alpha.ascii')

---@return table
local function layout()
    math.randomseed(os.time())
    local header_color = "AlphaCol" .. math.random(11)

    return {
        {
            type = "group",
            val = asciiheader(),
            opts = { spacing = 1, position = "center" }
        },
        {
            type = "group",
            val = buttons(),
            opts = { spacing = 1, position = "center" }
        },
        { type = "padding", val = 1 },
        {
            type = "text",
            val = vim.g.colors_name,
            opts = { hl = "AlphaCol1", position = "center" }
        },
        { type = "padding", val = 1 },
        {
            type = "text",
            val = lazycache "info",
            opts = { hl = header_color, position = "center" },
        },
        { type = "padding", val = 1 },
        -- {
        --     type = "text",
        --     val = "  00-00-0000   00:00:00",
        --     opts = { hl = "AlphaCol1", position = "center" }
        -- },
        -- {
        --     type = "text",
        --     val = "󰂖 00   0.0.0  00:00:00",
        --     opts = { hl = "AlphaCol1", position = "center" }
        -- },
        {
            type = "text",
            val = "Recent Files",
            opts = { hl = "AlphaCol1", position = "center" }
        },
        {
            type = "group",
            val = lazycache "mru",
            opts = { spacing = 0 },
        },
        { type = "padding", val = 1 },
        {
            type = "text",
            val = lazycache "fortune",
            opts = { hl = "AlphaQuote", position = "center" },
        },

    }
end

return layout();
