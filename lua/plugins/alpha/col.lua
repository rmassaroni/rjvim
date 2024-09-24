local col = function(btnlist, opts)
  -- btnlist is a TABLE of TABLES, representing columns of buttons
  -- opts is a text display option

  -- column spacing
  local padding = 12
  -- fill lines up to the maximum length with 'fillchar'
  local fillchar = ' '
  -- columns padding char (for testing)
  local padchar = ' '

  -- define maximum button label length in a table
  local maxlen = function(str)
    local max = 0
    for i, v in pairs(str) do
      local btn_label = v.val -- access the button label
      if #btn_label > max then
        max = #btn_label
      end
    end
    return max
  end

  -- add as much right-padding to align the text block
  local pad = function(str, max)
    local padded_btns = {}
    for i, btn in pairs(str) do
      local btn_label = btn.val
      if #btn_label < max then
        local newlabel = btn_label .. string.rep(fillchar, max - #btn_label)
        -- clone the button and update its label
        local newbtn = {
          type = "button",
          val = newlabel,
          on_press = btn.on_press,
          opts = btn.opts,
        }
        table.insert(padded_btns, newbtn)
      else
        table.insert(padded_btns, btn)
      end
    end
    return padded_btns
  end

  -- this is a table for button elements
  local values = {}
  -- process all the lines (maximum number of rows)
  for i = 1, maxlen(btnlist) do
    local str = ''
    local row_buttons = {}
    -- process all the columns but the last
    for column = 1, #btnlist - 1 do
      local maxstr = maxlen(btnlist[column])
      local padded = pad(btnlist[column], maxstr)
      if btnlist[column][i] == nil then
        str = str .. string.rep(fillchar, maxstr) .. string.rep(padchar, padding)
      else
        local btn = padded[i]
        table.insert(row_buttons, btn)
      end
    end

    -- process the last column (no extra padding)
    do
      local maxstr = maxlen(btnlist[#btnlist])
      local padded = pad(btnlist[#btnlist], maxstr)
      if btnlist[#btnlist][i] == nil then
        str = str .. string.rep(fillchar, maxlen(btnlist[#btnlist]))
      else
        local btn = padded[i]
        table.insert(row_buttons, btn)
      end
    end

    -- insert result into output table
    for _, btn in pairs(row_buttons) do
      table.insert(values, { type = "button", val = btn.val, on_press = btn.on_press, opts = btn.opts })
    end
  end

  return values
end

return col
-- local col = function(strlist, opts)
--   -- strlist is a TABLE of TABLES, representing columns of text
--   -- opts is a text display option
--
--   -- column spacing
--   local padding = 12
--   -- fill lines up to the maximim length with 'fillchar'
--   local fillchar = ' '
--   -- columns padding char (for testing)
--   local padchar = ' '
--
--   -- define maximum string length in a table
--   local maxlen = function(str)
--     local max = 0
--     for i in pairs(str) do
--       if #str[i] > max then
--         max = #str[i]
--       end
--     end
--     return max
--   end
--
--   -- add as much right-padding to align the text block
--   local pad = function(str, max)
--     local strlist = {}
--     for i in pairs(str) do
--       if #str[i] < max then
--         local newstr = str[i] .. string.rep(fillchar, max-#str[i])
--         table.insert(strlist, newstr)
--       else
--         table.insert(strlist, str[i])
--       end
--     end
--     return strlist
--   end
--
--   -- this is a table for text strings
--   local values = {}
--   -- process all the lines
--   for i=1,maxlen(strlist) do
--     local str = ''
--     -- process all the columns but last, because we dont wand extra padding
--     -- after last column
--     for column=1,#strlist-1 do
--       local maxstr = maxlen(strlist[column])
--       local padded = pad(strlist[column], maxstr)
--       if strlist[column][i] == nil then
--         str = str .. string.rep(fillchar, maxstr) .. string.rep(padchar, padding)
--       else
--         str = str .. padded[i] .. string.rep(padchar, padding)
--       end
--     end
--
--     -- lets process the last column, no extra padding
--     do
--       local maxstr = maxlen(strlist[#strlist])
--       local padded = pad(strlist[#strlist], maxstr)
--       if strlist[#strlist][i] == nil then
--         str = str .. string.rep(fillchar, maxlen(strlist[#strlist]))
--       else
--         str = str .. padded[i]
--       end
--     end
--
--     -- insert result into output table
--     table.insert(values, { type = "text", val = str, opts = opts })
--   end
--
--   return values
-- end
--
-- return col
