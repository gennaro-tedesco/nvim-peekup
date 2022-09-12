describe("validate custom register string", function()
	local config = require("nvim-peekup.config")
	local valid_reg, invalid_reg

	setup(function()
		valid_reg = "a"
		invalid_reg = "!"
	end)

	it("validate register #validate_reg", function()
		assert.are_same(config.validate_reg(valid_reg), valid_reg)
		assert.are_same(config.validate_reg(invalid_reg), "*")
	end)
end)
