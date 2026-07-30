return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT", -- Neovim runs on blazing-fast LuaJIT
			},
			diagnostics = {
				-- Stops the server from spamming errors about global variables
				globals = { "vim", "hs" },
			},
			workspace = {
				-- Dynamically pull in all core Neovim runtime internal bindings
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
					"/usr/share/hypr/stubs"
				},
				checkThirdParty = false, -- Disables annoying popups asking to configure environments
			},
			telemetry = { enable = false },
			completion = {
				callSnippet = "Replace", -- Improves autocomplete signature drop-downs as you type
			},
		},
	},
}

