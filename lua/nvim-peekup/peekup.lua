local function reg2t()
   local reg = vim.api.nvim_exec([[registers]], true)
   local lines = {}
   for s in string.gmatch(reg, "[^\n]+") do
	  table.insert(lines, s)
   end
   return lines
end

local function peekup_open()
   local buf = vim.api.nvim_create_buf(false, true)

   local lines = reg2t()
   vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)
   vim.api.nvim_buf_set_option(buf, 'filetype', 'peek')

   local opts = {
	  relative = 'win',
	  width = 100,
	  height = 20,
	  col = vim.api.nvim_win_get_width(0)-2,
	  row = 2,
	  anchor = 'NE',
	  focusable = true,
	  style = 'minimal'
   }
   local win = vim.api.nvim_open_win(buf, 0, opts)
   vim.api.nvim_buf_set_keymap(buf, 'n', '<ESC>', ':q<CR>', { nowait = true, noremap = true, silent = true })
end

return {
   reg2t = reg2t,
   peekup_open = peekup_open,
}
