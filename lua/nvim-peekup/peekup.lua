local config = require("nvim-peekup.config")

local function centre_string(s)
   local width = vim.api.nvim_win_get_width(0)
   local shift = math.floor(width / 2) - math.floor(string.len(s) / 2)
   return string.rep(' ', shift)..s
end

local function get_reg(char)
	return vim.api.nvim_exec([[echo getreg(']]..char..[[')]], true):gsub("[\n\r]", "^J")
end

local function reg2t()
   -- parses the registers into a lua table
   local numerical_reg = {}
   table.insert(numerical_reg, '-- Numerical -> press number to copy')
   for _, v in pairs(config.reg_chars) do
	  if string.match(v, "%d") and get_reg(v) ~='' then
		 table.insert(numerical_reg, v..':'..string.rep(' ', config.on_keystroke.padding)..get_reg(v))
	  end
   end
   table.insert(numerical_reg, '')

   local alpha_reg = {}
   table.insert(alpha_reg, '-- Literal -> press letter to copy')
   for _, v in pairs(config.reg_chars) do
	  if string.match(v, "%a") and get_reg(v) ~='' then
		 table.insert(alpha_reg, v..':'..string.rep(' ', config.on_keystroke.padding)..get_reg(v))
	  end
   end
   table.insert(alpha_reg, '')

   local special_reg = {}
   table.insert(alpha_reg, '-- Special -> press character to copy')
   for _, v in pairs(config.reg_chars) do
	  if string.match(v, "%p") and get_reg(v) ~='' then
		 table.insert(special_reg, v..':'..string.rep(' ', config.on_keystroke.padding)..get_reg(v))
	  end
   end
   table.insert(special_reg, '')

   local reg = {}
   local n = 0
   for _,v in ipairs(numerical_reg) do n=n+1; reg[n]=v end
   for _,v in ipairs(alpha_reg) do n=n+1; reg[n]=v end
   for _,v in ipairs(special_reg) do n=n+1; reg[n]=v end
   return reg
end

local function floating_window(geometry)
   -- create internal window
   local total_width = vim.api.nvim_get_option("columns")
   local total_height = vim.api.nvim_get_option("lines")
   local win_width = geometry.width <=1 and math.ceil(total_width * geometry.width) or total_width
   local win_height = geometry.height <=1 and math.ceil(total_height * geometry.height) or total_height
   local win_opts = {
	  relative = 'win',
	  width = win_width,
	  height = win_height,
	  row = math.ceil((total_height - win_height) / 2 - 1),
	  col = math.ceil(total_width - win_width)/2,
	  focusable = true,
	  style = 'minimal'
   }
   local buf = vim.api.nvim_create_buf(false, true)

   -- create external window
   local border_opts = {
	  style = "minimal",
	  relative = "editor",
	  width = win_width + 2,
	  height = win_height + 2,
	  row = math.ceil((total_height - win_height) / 2 - 1) - 1,
	  col = math.ceil(total_width - win_width)/2 - 1
   }
   local border_buf = vim.api.nvim_create_buf(false, true)
   local border_lines = { '╔' .. string.rep('═', win_width) .. '╗' }
   local middle_line = '║' .. string.rep(' ', win_width) .. '║'
   for _=1, win_height do
	  table.insert(border_lines, middle_line)
   end
   table.insert(border_lines, '╚'..string.rep('═', win_width - (#geometry.name + 2) )..' '..geometry.name..' '..'╝')
   vim.api.nvim_buf_set_lines(border_buf, 0, -1, false, border_lines)

   vim.api.nvim_open_win(border_buf, true, border_opts)
   vim.api.nvim_open_win(buf, 0, win_opts)
   vim.cmd('au BufWipeout <buffer> exe "silent bwipeout! "'..border_buf)
   return buf
end

local function on_keystroke(key)
   -- defines the action to be undertaken upon keystroke in the peekup window
   local search_key = key=='*' and '\\'..key or key
   if vim.api.nvim_exec('echo search("^'..search_key.. ':") > 0', true) ~= '0' then
	  vim.cmd(':silent! /^'..search_key..':')
	  vim.cmd(':noh')
	  vim.cmd('execute "normal! ^f:'..config.on_keystroke.padding+1 ..'lvg_"')
	  vim.cmd('redraw')
	  vim.cmd('sleep '..config.on_keystroke.delay)
	  vim.cmd('execute "normal! \\<Esc>^"')
	  vim.cmd('let @*=@'..key)
	  if config.on_keystroke.autoclose then
		 vim.cmd('redraw')
		 vim.cmd('sleep '..config.on_keystroke.delay)
		 vim.cmd(':q')
	  end
   else
	  vim.cmd('echo "register '..key..' not available"')
   end
end

return {
   centre_string = centre_string,
   reg2t = reg2t,
   floating_window = floating_window,
   on_keystroke = on_keystroke,
}
