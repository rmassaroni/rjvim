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

return buttons
