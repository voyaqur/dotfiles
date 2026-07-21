-- keep
vim.pack.add({
	{ src = 'https://github.com/nvim-tree/nvim-web-devicons' },
	{ src = 'https://github.com/olimorris/onedarkpro.nvim' },

})
require("onedarkpro").setup({

	highlights = {
		Comment = { italic = true, extend = true }
	},

	plugins = {
		all = true
	},

	options = {
		cursorline = true,
		terminal_colors = true
	}
})
vim.cmd("colorscheme onedark_dark")
