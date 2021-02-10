local geometry = {
   width = 0.7, -- as ratio of the entire window width: 0 < x < 1
   height = 0.7, -- as ratio of the entire window height: 0 < x < 1
   title = 'Registers',
   name = 'peekup',
}

local on_keystroke = {
   delay = '700ms',
   autoclose = true,
}

local reg_chars = {}
local chars = 'abcdefghijklmnopqrstuvwxyz0123456789*+-%'
chars:gsub(".",function(c) table.insert(reg_chars,c) end)

return {
   geometry = geometry,
   on_keystroke = on_keystroke,
   reg_chars = reg_chars,
}
