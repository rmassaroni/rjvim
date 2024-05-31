return {
    "rmassaroni/nvim-gpush",

    config = function ()
        require("nvim-gpush").setup({
            one_liner = true,
            default_commit_message = "unnamed commit",
            debug_mode = true,
            file_specifc_configs = {
                lua = {
                    default_commit_message = "lua test"
                },
                java = {
                    default_commit_message = "java test"
                }
            }
        })
    end
}
