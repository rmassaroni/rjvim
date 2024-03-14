return {
   	"goolord/alpha-nvim",
    config = function ()
        local alpha = require'alpha'
        local dashboard = require'alpha.themes.dashboard'
 	    dashboard.section.header.val = require("plugins.alpha.rjvim")
	    dashboard.section.buttons.val = {
       	    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("p", "P  New project", ":<CR>"),
--            dashboard.button("s", "S  Script", ":e ~/.bashrc<CR>"),
            dashboard.button("t", "ℸ  Open tree", ":NvimTreeOpen<CR>"),
	 	    dashboard.button("c", "ᓵ  Config", ":e $HOME/.config/nvim/init.lua<CR> :cd $HOME/.config/nvim/lua/plugins<CR> :NvimTreeOpen<CR>"),
            dashboard.button("l", "ꖎ  Lazy", ":Lazy<CR>"),
            dashboard.button("m", "ᒲ  Mason", ":Mason<CR>"),
    	    dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
            --dashboard.button("<Right>", "Toggle", reload_dashboard)
        }
      	--local handle = io.popen('fortune')
 		--local fortune = handle:read("*a")
  		--handle:close()
 		--dashboard.section.footer.val = fortune
        dashboard.section.footer.val = vim.g.colors_name
  	    dashboard.config.opts.noautocmd = true
     	--vim.cmd[[autocmd User AlphaReady echo 'ready']]
 	    alpha.setup(dashboard.config)
	end
}
--rjvim: ∷⋮⍊╎ᒲ
