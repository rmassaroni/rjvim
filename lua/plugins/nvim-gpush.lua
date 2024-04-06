return {
    "rmassaroni/nvim-gpush",

    config = function ()
        require("nvim-gpush").setup({
            one_liner = true,
            default_commit_message = "default commit"
        })
    end
}
