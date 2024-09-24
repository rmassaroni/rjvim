local lazycache = setmetatable({}, {
    __newindex = function(table, index, fn)
        assert(type(fn) == "function")
        getmetatable(table)[index] = fn
    end,
    __call = function(table, index)
        return function()
            return table[index]
        end
    end,
    __index = function(table, index)
        local fn = getmetatable(table)[index]
        if fn then
            local value = fn()
            rawset(table, index, value)
            return value
        end
    end,
})

---@return string
lazycache.info = function()
    local plugins = #vim.tbl_keys(require("lazy").plugins())
    local v = vim.version()
    local datetime = os.date " %d-%m-%Y   %H:%M:%S"
    local platform = vim.fn.has "win32" == 1 and "" or ""
    return string.format("󰂖 %d  %s %d.%d.%d  %s", plugins, platform, v.major, v.minor, v.patch, datetime)
end

---@return table
lazycache.mru = function()
    local result = {}
    for _, filename in ipairs(vim.v.oldfiles) do
        -- if vim.loop.fs_stat(filename) ~= nil then
        if vim.fn.filereadable(filename) == 1 then
            local icon, hl = require("nvim-web-devicons").get_icon(filename, vim.fn.fnamemodify(filename, ":e"))
            local filename_short = string.sub(vim.fn.fnamemodify(filename, ":t"), 1, 30)
            table.insert(
                result,
                require("alpha.themes.dashboard").button(
                    tostring(#result + 1),
                    string.format("%s  %s", icon, filename_short),
                    string.format("<Cmd>e %s<CR>", filename),
                    nil,
                    { hl = { { hl, 0, 3 }, { "Normal", 5, #filename_short + 5 } } }
                )
            )
            if #result == 9 then
                break
            end
        end
    end
    return result
end

---@return table
lazycache.fortune = function()
    return require "alpha.fortune"()
end

---@return table
local function buttons()
    local button = require("alpha.themes.dashboard").button
    return {
        button("e", "  New file", ":ene <BAR> startinsert <CR>"),
        button("t", "ℸ  Open tree", ":NvimTreeOpen<CR>"),
        button("l", "ꖎ  Lazy", ":Lazy<CR>"),
        button("m", "ᒲ  Mason", ":Mason<CR>"),
        button("q", "󰅚  Quit NVIM", ":qa<CR>")
    }
end

---@return table
local function layout()
    math.randomseed(os.time())
    local header_color = "AlphaCol" .. math.random(11)

    return {
        { type = "padding", val = 1 },
        {
            type = "text",
            -- val = ascii,
            val = require('plugins.alpha.ascii'),
            -- opts = { hl = "AlphaCol1", position = "center" }
            opts = { hl = header_color, position = "center" } --not working
        },
        { type = "padding", val = 1 },
        {
            type = "group",
            val = {
                { -- Left side for buttons
                    type = "group",
                    val = buttons(),
                    opts = { spacing = 1, position = "left" }
                },
                -- { type = "padding", val = 1 },
                { -- Right side for recent files
                    type = "group",
                    val = lazycache "mru",
                    opts = { spacing = 1, position = "right" }
                },
                -- opts = { width = 80, position = "center" } -- Adjust the width as needed
            }
        },

        -- {
        --     type = "group",
        --     val = buttons(),
        --     opts = { spacing = 1 }
        -- },
        { type = "padding", val = 1 },
        {
            type = "text",
            val = "  00-00-0000   00:00:00",
            opts = { hl = "AlphaCol1", position = "center" }
        },
        {
            type = "text",
            val = "󰂖 00   0.0.0  00:00:00",
            opts = { hl = "AlphaCol1", position = "center" }
        },
        -- {
        --     type = "text",
        --     val = "Recent Files",
        --     opts = { hl = "AlphaCol1", position = "center" }
        -- },
        -- {
        --     type = "group",
        --     val = lazycache "mru",
        --     opts = { spacing = 1 },
        -- },
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
        {
            type = "text",
            val = lazycache "fortune",
            opts = { hl = "AlphaQuote", position = "center" },
        },

    }
end


local config = {
    "goolord/alpha-nvim",
    event = "VimEnter", -- correct cursor position
    config = function()
        local alpha = require'alpha'

        -- vim.api.nvim_create_autocmd("User", {
        --     pattern = "AlphaReady",  -- When Alpha is ready
        --     callback = function()
        --         vim.defer_fn(function()
        --             vim.cmd("Mason")  -- Open the Mason buffer
        --         end, 1000)  -- Delay in milliseconds (e.g., 1 second)
        --     end,
        -- })

        -- vim.api.nvim_create_autocmd("User", {
        --     pattern = "AlphaReady",  -- When Alpha is ready
        --     callback = function()
        --         vim.defer_fn(function()
        --             -- Open Mason in a horizontal split taking half the screen
        --             vim.cmd("belowright split | resize " .. math.floor(vim.o.lines / 2) .. " | Mason")
        --         end, 1000)  -- Delay in milliseconds (e.g., 1 second)
        --     end,
        -- })

        alpha.setup {
            layout = layout()
        }
    end
}

return config


--leader key
--plugins
--date
--neofetch
--cowsay
--colors not working
--config shortcut
--custom user commands and keymaps list
--
--
--local newconfig = {
--     "goolord/alpha-nvim",
--     event = "VimEnter", -- correct cursor position
--     config = function()
--         local alpha = require'alpha'
--         local dashboard = require'alpha.themes.dashboard'
--         -- dashboard.section.header.val = ascii
--         -- dashboard.section.buttons.val = {
--         --     dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
--         --     dashboard.button("t", "ℸ  Open tree", ":NvimTreeOpen<CR>"),
--         --     dashboard.button("l", "ꖎ  Lazy", ":Lazy<CR>"),
--         --     dashboard.button("m", "ᒲ  Mason", ":Mason<CR>"),
--         --     dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
--         -- }
--         -- dashboard.section.footer.val = vim.g.colors_name
--         -- dashboard.config.opts.noautocmd = true
--         -- alpha.setup(dashboard.config)
--
--         alpha.setup {
--             layout = {
--                 { type = "padding", val = 1 },
--                 {
--                     type = "text",
--                     val = ascii,
--                     opts = { hl = "AlphaCol1", position = "center" }
--                 },
--                 { type = "padding", val = 1 },
--                 {
--                     type = "group",
--                     val = {
--                         dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
--                         dashboard.button("t", "ℸ  Open tree", ":NvimTreeOpen<CR>"),
--                         dashboard.button("l", "ꖎ  Lazy", ":Lazy<CR>"),
--                         dashboard.button("m", "ᒲ  Mason", ":Mason<CR>"),
--                         dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>")
--                     },
--                     opts = { spacing = 1 }
--                 },
--                 { type = "padding", val = 1 },
--                 {
--                     type = "text",
--                     val = vim.g.colors_name,
--                     opts = { hl = "AlphaCol1", position = "center" }
--                 }
--             }
--         }
--     end
-- }

