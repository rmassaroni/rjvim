local ascii = {
    "       _       _               ",
    "      (_)     (_)              ",
    "  _ __ ___   ___ _ __ ___      ",
    " | '__| \\ \\ / / | '_ ` _ \\  ",
    " | |  | |\\ V /| | | | | | |   ",
    " |_|  | | \\_/ |_|_| |_| |_|   ",
    "     _/ |                      ",
    "    |__/                       "
}

---@return table
local function asciiheader()
    return {
        { type = "padding", val = 1 },
        {
            type = "text",
            val = ascii,
            -- opts = { hl = "AlphaCol1", position = "center" }
            opts = {
                position = "center",
                hl = "Type",
                -- wrap = "overflow";
            },
        },
        { type = "padding", val = 0 }
    }
end

return asciiheader
