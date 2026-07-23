local map = vim.keymap.set
-- vim.opt.completeopt = { "menu", "noselect", "popup" }
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		if not client then
			return
		end
		client.server_capabilities.semanticTokensProvider = nil
		-- Buffer-local opts helper
		local function opts(desc)
			return { buffer = ev.buf, silent = true, desc = desc }
		end

		-- FzfLua Navigation
		map("n", "<leader>fgd", "<cmd>FzfLua lsp_definitions<CR>", opts("Go to Definition"))
		map("n", "<leader>fgr", "<cmd>FzfLua lsp_references<CR>", opts("Go to References"))
		map("n", "<leader>fgI", "<cmd>FzfLua lsp_implementations<CR>", opts("Go to Implementation"))
		map("n", "<leader>fca", "<cmd>FzfLua lsp_code_actions<CR>", opts("Code Actions"))
		map("n", "<leader>fld", "<cmd>FzfLua diagnostics_document<CR>", opts("Document Diagnostics"))
		map("n", "<leader>fw", "<cmd>FzfLua diagnostics_workspace<CR>", opts("Workspace Diagnostics"))
		map("n", "<leader>fls", "<cmd>FzfLua lsp_document_symbols<CR>", opts("Document Symbols"))
		map("n", "<leader>lS", "<cmd>FzfLua lsp_live_workspace_symbols<CR>", opts("Workspace Symbols"))

		-- Built-in LSP Navigation & Actions
		map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
		map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
		map("n", "gi", vim.lsp.buf.implementation, opts("List implementations"))
		map("n", "go", vim.lsp.buf.type_definition, opts("Go to type definition"))
		map("n", "gr", vim.lsp.buf.references, opts("List all references"))
		map("n", "K", vim.lsp.buf.hover, opts("Show documentation hover"))
		map("n", "<C-k>", vim.lsp.buf.signature_help, opts("Show signature help"))
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Execute code action"))
		map("n", "<leader>rn", vim.lsp.buf.rename, opts("Structural variable renaming"))

		-- Diagnostics
		map("n", "<leader>D", vim.diagnostic.open_float, opts("Show line diagnostics"))
		map("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts("Previous diagnostic"))
		map("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts("Next diagnostic"))
		map("n", "<leader>q", vim.diagnostic.setloclist, opts("Open diagnostics list"))

		-- Inlay Hints
		if client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
			map("n", "<leader>th", function()
				local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf })
				vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = ev.buf })
				vim.notify("Inlay Hints " .. (is_enabled and "Disabled" or "Enabled"))
			end, opts("Toggle Inlay Hints"))
		end
		-- vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		-- Native Completion
		if client:supports_method("textDocument/completion") then
			-- goodbye
			vim.lsp.completion.enable(false, client.id, ev.buf, {})
			-- vim.lsp.completion.enable(true, client.id, ev.buf, {
			-- 	autotrigger = true,
			-- 	convert = function(item)
			-- 		return {
			-- 			abbr = item.label:gsub("%b()", ""),
			-- 		}
			-- 	end,
			--
			-- 	vim.keymap.set("i", "<C-space>", vim.lsp.completion.get, { desc = "trigger autocompletion" })
			-- })
		end
		-- Formatting: Defines buffer command :Fmt and binds to <leader>fm
		if client:supports_method("textDocument/formatting") then
			local format_func = function()
				local has_conform, conform = pcall(require, "conform")
				if has_conform then
					conform.format({ async = true, lsp_fallback = true })
				else
					vim.lsp.buf.format({ async = true, id = client.id })
				end
			end
			vim.api.nvim_buf_create_user_command(ev.buf, "Fmt", format_func, { desc = "Format current buffer" })
		end
	end,
})
vim.lsp.enable({ "lua-ls", "clangd" })
