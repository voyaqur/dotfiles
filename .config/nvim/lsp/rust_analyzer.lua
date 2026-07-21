return {
	filetypes = { "rust" },
	cmd = { "rust-analyzer" },
	root_markers = { "Cargo.toml", "rust-project.json", ".git" },
	settings = {
		["rust-analyzer"] = {
			inlayHints = {
				bindingModeHints = { enable = true },
				chainingHints = { enable = true },
				closingBraceHints = { enable = true, minLines = 25 },
				parameterHints = { enable = true },
				typeHints = { enable = true },
			},
			workspace = {
				symbol = {
					search = { scope = "workspace_and_dependencies" }, -- Better workspace-wide search
				},
			},
			-- 3. Better diagnostics
			diagnostics = {
				enable = true,
				disabled = { "unresolved-proc-macro" }, -- Prevents annoying macro false-positives
			},
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
			checkOnSave = true,
		},
	},
}
