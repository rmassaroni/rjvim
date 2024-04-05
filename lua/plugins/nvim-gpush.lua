return {
    "rmassaroni/nvim-gpush",

    opts = {
        one_liner = false
    },
    config = function ()
        local gp = require("nvim-gpush")
        gp.setup({
            one_liner = false
        })
    end
}
