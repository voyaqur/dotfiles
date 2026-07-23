--
require("core.base")
require("core.opts")
require("theme")
require("core.maps")
require("treesitter")
require("core.autocmd")
require("installs")
require("debugger")
require("lang.rust")
vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter" }, {
	group = nil,
	once = true,
	callback = function()
		vim.schedule(function()
			require("plugins")
			require("lsp")
			require("builtin")
		end)
		vim.defer_fn(function()
			require("core.cmd")
		end, 50)
	end,
})
