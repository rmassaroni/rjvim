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
    -- local color = vim.g.colors_name
    local datetime = os.date " %m-%d-%Y   %I:%M %p"
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

return lazycache
