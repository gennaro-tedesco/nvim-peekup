--[[ this module exposes the interfece to toggle comments: it detects
the buffer filetype and retrieves the corresponding configuration.
If the selection is multiline, it toggles block comments, otherwise it
defaults to single comments --]]

local peekup = require("nvim-peekup.peekup")
local config = require("nvim-peekup.config")

local function peekup_open()
   local peekup_buf = peekup.floating_window(config.geometry)
   local lines = peekup.reg2t()
   table.insert(lines, 1, peekup.centre_string(config.geometry.title))
   table.insert(lines, 2, '')

   vim.api.nvim_buf_set_lines(peekup_buf, 0, -1, true, lines)
   vim.api.nvim_buf_set_option(peekup_buf, 'filetype', 'peek')
   vim.api.nvim_buf_set_keymap(peekup_buf, 'n', '<ESC>', ':q<CR>', { nowait = true, noremap = true, silent = true })
   for k, v in ipairs(config.reg_chars) do
	  vim.api.nvim_buf_set_keymap(peekup_buf, 'n', v, ':lua require"nvim-peekup.peekup".on_keystroke(\"'..v..'\")<cr>', { nowait = true, noremap = true, silent = true })
   end
end

return {
   peekup_open = peekup_open,
}

