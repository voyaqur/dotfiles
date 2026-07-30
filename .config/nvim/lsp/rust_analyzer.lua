return {
	filetypes = { "rust" },
	cmd = { "rust-analyzer" },
	root_markers = { "Cargo.toml", "rust-project.json", ".git" },
	settings = {
		["rust-analyzer"] = {

			cargo = {
				allFeatures = true,
				buildScripts = { enable = true },
				loadOutDirsFromCheck = true, -- needed for build-script-generated code to resolve correctly
				-- extraEnv = { CARGO_INCREMENTAL = "1" },
				extraArgs = { "--target-dir", "target/rust-analyzer" },
			},
			workspace = {
				symbol = {
					search = { scope = "workspace_and_dependencies" },
				},
			},
			procMacro = { enable = true },
			checkOnSave = true,
			check = {
				command = "clippy", -- clippy lints instead of plain cargo check — this alone is a huge upgrade
				-- extraArgs = { "--all-targets" },
				extraEnv = { RUSTFLAGS = "-W clippy::pedantic" },
			},

			hover = {
				actions = {
					enable = true,
					implementations = { enable = true },
					references = { enable = true },
					run = { enable = true },
					debug = { enable = true },
					gotoTypeDef = { enable = true },
				},
				documentation = { enable = true },
				links = { enable = true },
			},
			interpret = { tests = true },

			assist = {
				emitMustUse = true,              -- adds #[must_use] when generating functions that return values
				expressionFillDefault = "todo",  -- fills missing match arms with `todo!()` instead of `()`
			},
			showUnlinkedFileNotification = false, -- silences the "file not part of any crate" popup for scratch files

			-- Type/trait hints even more aggressive
			typing = {
				autoClosingAngleBrackets = { enable = true }, -- auto-close `<>` in generics
			},
			cachePriming = {
				enable = true, -- warms rust-analyzer's cache on startup so first queries aren't slow
			},
			inlayHints = {
				bindingModeHints = { enable = true },
				chainingHints = { enable = true },
				closingBraceHints = { enable = true, minLines = 25 },
				closureReturnTypeHints = { enable = "always" },
				lifetimeElisionHints = { enable = "skip_trivial" },
				parameterHints = { enable = true },
				typeHints = { enable = true },
				expressionAdjustmentHints = { enable = "reborrow" }, -- shows implicit &/&mut/deref, genuinely IDE-tier
				discriminantHints = { enable = "fieldless" },    -- shows enum discriminant values inline
			},
			diagnostics = {
				enable = true,
				disabled = { "unresolved-proc-macro" },
				experimental = { enable = true }, -- turns on rust-analyzer's newer experimental diagnostics
			},
			imports = {
				granularity = { group = "module" },
				prefix = "self",
			},
			lens = {
				enable = true,
				implementations = { enable = true },
				references = {
					adt = { enable = true },
					trait = { enable = true },
					method = { enable = true }, -- CodeLens showing reference counts above fns/structs/traits, like RustRover's gutter icons
				},
				run = { enable = true },
				debug = { enable = true },
			},
			completion = {
				postfix = { enable = true }, -- .if, .match, .unwrap postfix completions
				autoimport = { enable = true },
				fullFunctionSignatures = { enable = true },
			},

			files = {
				excludeDirs = { "target", ".git" }, -- keeps file-watching off build artifacts, meaningfully faster on large workspaces
			},
			highlightRelated = {
				breakPoints = { enable = true },
				exitPoints = { enable = true },
				references = { enable = true },
				yieldPoints = { enable = true },
			},

			-- Signature help while typing function args
			signatureInfo = {
				detail = "full",
				documentation = { enable = true },
			},

			-- Semantic highlighting for operators/punctuation (very RustRover-like)
			semanticHighlighting = {
				operator = { enable = true },
				punctuation = { enable = true, separate = { macro = { bang = true } } },
			},

			-- Rename via LSP applies across the whole workspace correctly
			rename = { allowExternalItems = true },
		},
	},
}
