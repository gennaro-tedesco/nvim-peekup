local reg_chars = {}
local chars = "abcdefghijklmnopqrstuvwxyz0123456789-.%"
if vim.fn.has("clipboard") == 1 then
	chars = "abcdefghijklmnopqrstuvwxyz0123456789*+-.%"
end
chars:gsub(".", function(c)
	table.insert(reg_chars, c)
end)

local geometry = {
	width = 0.7,
	height = 0.7,
	title = "Registers",
	name = "peekup",
	wrap = true,
}

local function validate_reg(s)
	for _, v in ipairs(reg_chars) do
		if v == s then
			return s
		end
	end
	return "*"
end

local paste_reg = "*"
local on_keystroke = {
	delay = "700ms",
	autoclose = true,
	padding = 3,
	paste_reg = validate_reg(paste_reg),
}

return {
	reg_chars = reg_chars,
	geometry = geometry,
	on_keystroke = on_keystroke,
	validate_reg = validate_reg,
}
