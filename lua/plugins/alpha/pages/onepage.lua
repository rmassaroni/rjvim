local lazycache = require('plugins.alpha.lazycache.lazycache')
local buttons = require('plugins.alpha.buttons')
local asciiheader = require('plugins.alpha.ascii')

---@return table
local function layout()
    math.randomseed(os.time())
    local header_color = "AlphaCol" .. math.random(11) -- not working

    -- local function read_ascii_file(filepath)
    --     local lines = {}
    --     local file = io.open(filepath, "r")
    --     if file then
    --         for line in file:lines() do
    --             table.insert(lines, line)
    --         end
    --         file:close()
    --     else
    --         print("Could not read the Neofetch ASCII file: " .. filepath)
    --     end
    --     return lines
    -- end
    -- local function read_ascii_file(filepath)
    --     local lines = {}
    --     local file = io.open(filepath, "r")
    --     if file then
    --         for line in file:lines() do
    --             table.insert(lines, line)
    --         end
    --         file:close()
    --     else
    --         print("Could not read the Neofetch ASCII file: " .. filepath)
    --     end
    --     return lines
    -- end
    --
    -- local neofetch_ascii = read_ascii_file(vim.fn.stdpath('config') .. '/lua/plugins/alpha/output.txt')


    return {
        {
            type = "group",
            val = asciiheader(),
            opts = { spacing = 1, position = "center" }
        },
        {
            type = "text",
            val = lazycache "info",
            opts = { hl = header_color, position = "center" },
        },
        { type = "padding", val = 2 },
        {
            type = "group",
            val = buttons(),
            opts = { spacing = 1, position = "center" }
        },
        { type = "padding", val = 3 },
        {
            type = "text",
            val = "Recent Files",
            opts = { hl = "AlphaCol1", position = "center" }
        },
        { type = "padding", val = 1 },
        {
            type = "group",
            val = lazycache "mru",
            opts = { spacing = 0 },
        },
        { type = "padding", val = 3 },
        {
            type = "text",
            val = lazycache "fortune",
            opts = { hl = "AlphaQuote", position = "center" },
        },
        -- {
        --     type = "text",
        --     val = neofetch_ascii,
        --     opts = { hl = "AlphaCol2", position = "center", wrap = true },
        -- },


    }
end

return layout()
