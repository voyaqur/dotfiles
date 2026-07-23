--- sir Dr. rustasian

local map = vim.keymap.set
local rust_group = vim.api.nvim_create_augroup("LazyLoadRustTools", { clear = true })
vim.g.rustaceanvim = function()
	local lldb_path = vim.fn.exepath("lldb-dap")
	if lldb_path == "" then
		lldb_path = "/usr/bin/lldb-dap"
	end
	require("dap").adapters.lldb = {
		type = "executable",
		command = lldb_path,
		name = "lldb",
	}
	return {
		tools = {
			float_wins = {
				border = "none",
			},
		},
		server = {
			on_attach = function(_, bufnr)
				local opts = function(desc)
					return { buffer = bufnr, silent = true, desc = desc }
				end
				-- Execution & Debugging
				map("n", "<leader>rr", "<cmd>RustLsp runnables<CR>", opts("Runnables"))
				map("n", "<leader>rR", "<cmd>RustLsp run<CR>", opts("Run Target at Cursor"))
				map("n", "<leader>rd", "<cmd>RustLsp debuggables<CR>", opts("Debuggables"))
				map("n", "<leader>rD", "<cmd>RustLsp debug<CR>", opts("Debug Target at Cursor"))
				map("n", "<leader>rt", "<cmd>RustLsp testables<CR>", opts("Testables"))
				map("n", "<leader>rT", "<cmd>RustLsp relatedTests<CR>", opts("Related Tests"))

				-- Code Actions & Quick Fixes
				map("n", "<leader>ra", "<cmd>RustLsp codeAction<CR>", opts("Code Action (Grouped)"))
				map("n", "<leader>re", "<cmd>RustLsp explainError<CR>", opts("Explain Error"))

				-- Code Manipulation & AST
				map("n", "<leader>rj", "<cmd>RustLsp joinLines<CR>", opts("Join Lines"))
				map("n", "<leader>rK", "<cmd>RustLsp moveItem up<CR>", opts("Move Item Up"))
				map("n", "<leader>rJ", "<cmd>RustLsp moveItem down<CR>", opts("Move Item Down"))
				map("n", "<leader>rp", "<cmd>RustLsp parentModule<CR>", opts("Parent Module"))

				-- Diagnostics & Compiler Checks
				map("n", "<leader>rx", "<cmd>RustLsp rebuildProcMacros<CR>", opts("Rebuild Proc Macros"))
				map("n", "<leader>rn", "<cmd>RustLsp renderDiagnostic<CR>", opts("Render Diagnostic"))
				map("n", "<leader>rN", "<cmd>RustLsp relatedDiagnostics<CR>", opts("Related Diagnostics"))
				map("n", "<leader>rf", "<cmd>RustLsp flyCheck<CR>", opts("Fly Check"))

				-- Cargo & Workspace Tools
				map("n", "<leader>rc", "<cmd>RustLsp openCargo<CR>", opts("Open Cargo.toml"))
				map("n", "<leader>rw", "<cmd>RustLsp reloadWorkspace<CR>", opts("Reload Workspace"))
				map("n", "<leader>rg", "<cmd>RustLsp crateGraph<CR>", opts("Crate Graph"))
				map("n", "<leader>rW", "<cmd>RustLsp workspaceSymbol<CR>", opts("Workspace Symbols"))

				-- Documentation & Hover
				map("n", "<leader>rh", "<cmd>RustLsp hover actions<CR>", opts("Hover Actions"))
				map("n", "<leader>rk", "<cmd>RustLsp openDocs<CR>", opts("Open Docs.rs"))
				map("n", "<leader>rE", "<cmd>RustLsp externalDocs<CR>", opts("External Docs"))

				-- Low-Level / Compiler Inspection
				map("n", "<leader>rs", "<cmd>RustLsp syntaxTree<CR>", opts("Syntax Tree"))
				map("n", "<leader>rm", "<cmd>RustLsp expandMacro<CR>", opts("Expand Macro"))
				map("n", "<leader>rS", "<cmd>RustLsp ssr<CR>", opts("Structural Search Replace"))
				map("n", "<leader>ru", "<cmd>RustLsp unpretty<CR>", opts("Unpretty / MIR / HIR")) -- )
			end,
			dap = {
				adapter = {
					type = "executable",
					command = lldb_path,
					name = "lldb",
				},
			},
			default_settings = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
						buildScripts = { enable = true },
					},
					workspace = {
						symbol = {
							search = { scope = "workspace_and_dependencies" }, -- Better workspace-wide search
						},
					},
					procMacro = { enable = true },
					checkOnSave = true,
					inlayHints = {
						bindingModeHints = { enable = true },
						chainingHints = { enable = true },
						closingBraceHints = { enable = true, minLines = 25 },
						closureReturnTypeHints = { enable = "always" },
						lifetimeElisionHints = { enable = "skip_trivial" },
						parameterHints = { enable = true },
						typeHints = { enable = true },
					},
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
				},
			},
		},
	}
end

vim.pack.add({
	{ src = "https://github.com/mrcjkb/rustaceanvim" }, -- hard to setup but worth it
	{ src = "https://github.com/cordx56/rustowl" },
	{ src = "https://github.com/Saecki/crates.nvim" },
})
vim.api.nvim_create_autocmd("BufRead", {
	group = rust_group,
	pattern = "Cargo.toml",
	once = true,
	callback = function(ev)
		require("crates").setup({
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
		})
		local has_crates, crates = pcall(require, "crates")
		if has_crates then
			crates.show()
			local opts = { buffer = ev.buf, silent = true }
			vim.keymap.set(
				"n",
				"<leader>cv",
				crates.show_versions_popup,
				vim.tbl_extend("force", opts, { desc = "Crate Versions" })
			)
			vim.keymap.set(
				"n",
				"<leader>cf",
				crates.show_features_popup,
				vim.tbl_extend("force", opts, { desc = "Crate Features" })
			)
			vim.keymap.set(
				"n",
				"<leader>cu",
				crates.update_crate,
				vim.tbl_extend("force", opts, { desc = "Update Crate" })
			)
			vim.keymap.set(
				"n",
				"<leader>cU",
				crates.upgrade_crate,
				vim.tbl_extend("force", opts, { desc = "Upgrade Crate" })
			)
		end
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = rust_group,
	pattern = "rust",
	once = true,
	callback = function(ev)
		require("rustowl").setup({
			auto_enable = true,
			idle_time = 300,
			highlight_style = {
				definitely_live = 'underline',
				maybe_initialized = 'undercurl',
			},
			colors = {
				lifetime = '#50fa7b', -- Dracula green
				imm_borrow = '#8be9fd', -- Dracula cyan
				mut_borrow = '#ff79c6', -- Dracula pink
				move = '#f1fa8c',   -- Dracula yellow
				call = '#ffb86c',   -- Dracula orange
				outlive = '#ff5555',
			},
			client = {
				on_attach = function(_, buffer)
					vim.keymap.set('n', '<leader>ro', function()
						require('rustowl').toggle(buffer)
					end, { buffer = buffer, desc = 'Toggle RustOwl' })

					vim.keymap.set('n', '<leader>re', function()
						require('rustowl').enable(buffer)
					end, { buffer = buffer, desc = 'Enable RustOwl' })

					vim.keymap.set('n', '<leader>rd', function()
						require('rustowl').disable(buffer)
					end, { buffer = buffer, desc = 'Disable RustOwl' })
				end
			},
		})
		local has_wk, wk = pcall(require, "which-key")
		if has_wk then
			wk.add({
				{ "<leader>r", group = "Rust Tools", icon = "🦀", buffer = ev.buf },
			})
		end
	end,
})
