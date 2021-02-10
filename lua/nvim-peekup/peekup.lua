local config = require("nvim-peekup.config")

local function reg2t()
   local reg = vim.api.nvim_exec([[registers]], true)
   local lines = {}
   for s in string.gmatch(reg, "[^\n]+") do
	  table.insert(lines, s)
   end
   return lines
end

local function center(str)
   local width = vim.api.nvim_win_get_width(0)
   local shift = math.floor(width / 2) - math.floor(string.len(str) / 2)
   return string.rep(' ', shift) .. str
end

local function floating_window(geometry)
   -- create internal window
   local total_width = vim.api.nvim_get_option("columns")
   local total_height = vim.api.nvim_get_option("lines")
   local win_width = math.ceil(total_width * geometry.width)
   local win_height = math.ceil(total_height * geometry.height)
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
   table.insert(border_lines, '╚' .. string.rep('═', win_width) .. '╝')
   vim.api.nvim_buf_set_lines(border_buf, 0, -1, false, border_lines)

   vim.api.nvim_open_win(border_buf, true, border_opts)
   vim.api.nvim_open_win(buf, 0, win_opts)
   vim.cmd('au BufWipeout <buffer> exe "silent bwipeout! "'..border_buf)
   return buf
end

local function peekup_open()
   local peekup_buf = floating_window(config.geometry)
   local lines = center(config.geometry.title)
   local lines = reg2t()

   vim.api.nvim_buf_set_lines(peekup_buf, 0, -1, true, lines)
   vim.api.nvim_buf_set_option(peekup_buf, 'filetype', 'peek')
   vim.api.nvim_buf_set_keymap(peekup_buf, 'n', '<ESC>', ':q<CR>', { nowait = true, noremap = true, silent = true })
end

return {
   peekup_open = peekup_open,
}
