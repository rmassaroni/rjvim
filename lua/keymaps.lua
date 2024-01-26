vim.keymap.set('n', '<leader>t', ':NvimTreeOpen<CR>', {noremap = true})

currentTheme = 1
themes = {
    "tokyonight",
    "tokyonight-day",
    "tokyonight-night",
    "tokyonight-moon",
    "tokyonight-storm"
}
size = 5
--int previousTheme = 1
function getTheme(previousTheme --[[int]])
  --  print(currentTheme);
    currentTheme = previousTheme + 1;
    if(currentTheme > 5) then
        currentTheme = 1;
    end
    return currentTheme;
end
var = 1;

function toggle_theme()
    if(currentTheme > 4) then 
        currentTheme = 1;
    else
        currentTheme = currentTheme + 1;
    end;
    vim.cmd.colorscheme(themes[currentTheme]);
end

--vim.keymap.set('n', '<leader>c', ':colorsciheme '..getTheme()..'<CR> :lua print(":colorscheme "..getTheme())<CR><CR>', {noremap = true})
--vim.keymap.set('n', '<leader>h', ':lua if(currentTheme > 4) then currentTheme = 1; else currentTheme = currentTheme + 1; end; print(currentTheme); vim.cmd.colorscheme(themes[currentTheme])<CR><CR>', {noremap = true})



