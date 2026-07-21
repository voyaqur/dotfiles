return {
	formatters_by_ft = {
		rust = { "rustfmt", fallback = "lsp" }, -- Tells conform to cleanly fallback to rust-analyzer
		c = { "lsp" }, -- Lean on clangd natively
		cpp = { "lsp" },
		javascript = { "eslint_d", "prettierd" },
		typescript = { "eslint_d", "prettierd" },
		javascriptreact = { "eslint_d", "prettierd" },
		typescriptreact = { "eslint_d", "prettierd" },
		svelte = { "prettierd" },
		css = { "prettierd" },
		html = { "prettierd" },
		json = { "jq" },
		markdown = { "prettierd", "injected" }, -- Formats code blocks inside markdown
	},
	format_on_save = function()
		return {
			timeout_ms = 500,
			lsp_format = "fallback",
		}
	end,
	formatters = {
		shfmt = {
			prepend_args = { "-i", "2" },
		},
	},
}
