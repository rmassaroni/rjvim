return {
    'glacambre/firenvim',

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    --cond = not not vim.g.started_by_firenvim,
    lazy = not vim.g.started_by_firenvim,
    --lazy = false,
    --module = false,
    build = function()
        --require("lazy").load({ plugins = "firenvim", wait = true })
        vim.fn["firenvim#install"](0)
    end,
--[[
    config = function()
        vim.g.firenvim_config = {
            localSettings = {
                [".*"] = {
                    takeover = "never",
                },
            },
        }
    end
    --]]
}
