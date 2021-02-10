local geometry = {
   width = 0.7,
   height = 0.7,
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
