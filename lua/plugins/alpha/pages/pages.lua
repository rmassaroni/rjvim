local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')
local onepage = require('plugins.alpha.pages.onepage')

local pages = {
    -- {
        -- header = {
        --     type = "text",
        --     val = {
        --         "First Page",
        --         "------------------",
        --     },
        --     opts = {
        --         position = "center",
        --         hl = "Type"
        --     }
        -- },
        -- buttons = {
        --     type = "group",
        --     val = {
        --         dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
        --         dashboard.button("q", "  Quit", ":qa<CR>")
        --     },
        --     opts = {
        --         spacing = 1
        --     }
        -- }
        onepage,
    -- },
    {
        header = {
            type = "text",
            val = {
                "Second Page",
                "------------------",
            },
            opts = {
                position = "center",
                hl = "Type"
            }
        },
        buttons = {
            type = "group",
            val = {
                dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
                dashboard.button("q", "  Quit", ":qa<CR>")
            },
            opts = {
                spacing = 1
            }
        }
    }
}

local current_page = 1

local function set_page(page_num)
    if pages[page_num] then
        alpha.setup {
            layout = 
                -- { type = "padding", val = 2 },
                -- pages[page_num].header,
                -- { type = "padding", val = 2 },
                -- pages[page_num].buttons,
                pages[page_num]
            
        }
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
