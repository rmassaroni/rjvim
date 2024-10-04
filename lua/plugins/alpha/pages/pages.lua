local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')
local onepage = require('plugins.alpha.pages.onepage')
local statuspage = require('plugins.alpha.pages.statuspage')

local pages = {
    onepage,
    -- {
    --     header = {
    --         type = "text",
    --         val = {
    --             "Second Page",
    --             "------------------"
    --         },
    --         opts = {
    --             position = "center",
    --             hl = "Type"
    --         }
    --     },
    --     buttons = {
    --         type = "group",
    --         val = {
    --             dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
    --             dashboard.button("q", "  Quit", ":qa<CR>")
    --         },
    --         opts = {
    --             spacing = 1
    --         }
    --     }
    -- }
    -- statuspage
}

local current_page = 1

local function set_page(page_num)
    if pages[page_num] then
        alpha.setup {
            layout = pages[page_num]
        }
        -- maybe only redraw if page changed
        alpha.redraw()
    end
end

set_page(current_page)

local function next_page()
    current_page = (current_page % #pages) + 1
    set_page(current_page)
    print("Current Page: " .. current_page)
end

local function prev_page()
    current_page = (current_page - 2 + #pages) % #pages + 1
    set_page(current_page)
    print("Current Page: " .. current_page)
end

local function set_keymaps()
    vim.api.nvim_set_keymap('n', '<Right>', ':lua require("plugins.alpha.pages.pages").next_page()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Left>', ':lua require("plugins.alpha.pages.pages").prev_page()<CR>', { noremap = true, silent = true })
end

local M = {
    next_page = next_page,
    prev_page = prev_page
}

set_keymaps()

return M
