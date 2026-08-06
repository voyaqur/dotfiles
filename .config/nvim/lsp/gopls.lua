return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.work", "go.mod", ".git" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				shadow = true,
				unusedwrite = true,
				useany = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			gofumpt = true,         -- Use gofumpt instead of gofmt for stricter formatting
			staticcheck = true,     -- Enable staticcheck linter rules inside gopls
			completeUnimported = true, -- Auto-complete unimported packages
			usePlaceholders = true, -- Show parameter placeholders in auto-completions
			semanticTokens = true,  -- Enable semantic color highlighting
		},
	},
}
