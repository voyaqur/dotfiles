local default_config = {
	keymaps = {
	},
	ignore_filetypes = {},
	disable_inline_completion = true,
	disable_keymaps = true,
	condition = function()
		return false
	end,
	log_level = "off",
}

local M = {
	config = vim.deepcopy(default_config),
}

M.setup = function(args)
	M.config = vim.tbl_deep_extend("force", vim.deepcopy(default_config), args)
end

return setmetatable(M, {
	__index = function(_, key)
		if key == "setup" then
			return M.setup
		end
		return rawget(M.config, key)
	end,
})
