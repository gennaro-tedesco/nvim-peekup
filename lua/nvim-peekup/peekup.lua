local function reg2t()
   local reg = vim.api.nvim_exec([[registers]], true)
   local lines = {}
   for s in string.gmatch(reg, "[^\n]+") do
	  table.insert(lines, s)
   end
   return lines
end

local function floating_window()
   local buf = vim.api.nvim_create_buf(false, true)

   local win_opts = {
	  relative = 'win',
	  width = 100,
	  height = 20,
	  col = vim.api.nvim_win_get_width(0)-2,
	  row = 2,
	  anchor = 'NE',
	  focusable = true,
	  style = 'minimal'
   }
   vim.api.nvim_open_win(buf, 0, win_opts)
   return buf
end

local function peekup_open()
   local peekup_buf = floating_window()
   local lines = reg2t()
   vim.api.nvim_buf_set_lines(peekup_buf, 0, -1, true, lines)
   vim.api.nvim_buf_set_option(peekup_buf, 'filetype', 'peek')
   vim.api.nvim_buf_set_keymap(peekup_buf, 'n', '<ESC>', ':q<CR>', { nowait = true, noremap = true, silent = true })
end

return {
   peekup_open = peekup_open,
}
