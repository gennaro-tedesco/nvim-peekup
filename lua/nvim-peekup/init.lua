--[[ this module exposes the interface to open the peekup
window containing the registers content. Moreover it
sets the corresponding buffer options and commands on keystroke ]]

local peekup = require("nvim-peekup.peekup")
local config = require("nvim-peekup.config")

local function set_peekup_opts(buf)
   vim.api.nvim_buf_set_option(buf, 'filetype', 'peek')
   vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
   vim.api.nvim_buf_set_option(buf, 'modifiable', false)
   vim.api.nvim_buf_set_option(buf, 'readonly', true)
   vim.api.nvim_buf_set_keymap(buf, 'n', '<ESC>', ':q<CR>', { nowait = true, noremap = true, silent = true })
   for _, v in ipairs(config.reg_chars) do
	  vim.api.nvim_buf_set_keymap(buf, 'n', v, ':lua require"nvim-peekup.peekup".on_keystroke(\"'..v..'\")<cr>', { nowait = true, noremap = true, silent = true })
   end
end

local function peekup_open()
   local peekup_buf = peekup.floating_window(config.geometry)
   local lines = peekup.reg2t()
   table.insert(lines, 1, peekup.centre_string(config.geometry.title))
   table.insert(lines, 2, '')

   vim.api.nvim_buf_set_lines(peekup_buf, 0, -1, true, lines)
   set_peekup_opts(peekup_buf)
end

return {
   peekup_open = peekup_open,
}

