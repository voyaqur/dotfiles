local map = vim.keymap.set
vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Auto-format on save",
    callback = function(args)
        -- This natively checks if any attached LSP can format, and runs it synchronously before writing to disk
        vim.lsp.buf.format({
            async = false, -- Must be false so it finishes BEFORE the file is written!
            bufnr = args.buf
        })
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "cpp",
    callback = function()
        vim.keymap.set("n", "<F9>", function()
            vim.cmd("write")                          -- Save before running

            local file_path = vim.fn.expand("%:p")    -- Full absolute path to source file
            local binary_out = vim.fn.expand("%:p:r") -- Full absolute path without extension

            -- Construct the command with exact matching %s placeholders
            local compile_and_run = string.format(
                'g++ -O2 -std=c++20 -Wall -Wextra -Wshadow -DLOCAL "%s" -o "%s" && "%s"',
                file_path, binary_out, binary_out
            )

            -- Open the terminal split
            vim.cmd("split | term " .. compile_and_run)
            vim.cmd("startinsert")
        end, { buffer = true, desc = "Compile and Run C++" })
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

        map("n", "<leader>gd", "<cmd>FzfLua lsp_definitions<CR>", { desc = "Go to Definition", silent = true })
        map("n", "<leader>gr", "<cmd>FzfLua lsp_references<CR>", { desc = "Go to References", silent = true })
        map("n", "<leader>gI", "<cmd>FzfLua lsp_implementations<CR>",
            { desc = "Go to Implementation", silent = true })
        map("n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<CR>", { desc = "Code Actions", silent = true })
        map("n", "<leader>ld", "<cmd>FzfLua diagnostics_document<CR>",
            { desc = "Document Diagnostics", silent = true })
        map("n", "<leader>lD", "<cmd>FzfLua diagnostics_workspace<CR>",
            { desc = "Workspace Diagnostics", silent = true })
        map("n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<CR>",
            { desc = "Document Symbols", silent = true })
        map("n", "<leader>lS", "<cmd>FzfLua lsp_live_workspace_symbols<CR>",
            { desc = "Workspace Symbols", silent = true })
        map("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
        map("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to declaration" })
        map("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "List implementations" })
        map("n", "go", vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "Go to type definition" })
        map("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "List all references" })
        map("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Show documentation hover" })
        map("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Show signature help" })
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Execute code action" })
        map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Structural variable renaming" })
        map("n", "<leader>d", vim.diagnostic.open_float, { buffer = ev.buf, desc = "Show line diagnostics" })
        map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end,
            { buffer = ev.buf, desc = "Previous diagnostic" })
        map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end,
            { buffer = ev.buf, desc = "Next diagnostic" })
        map("n", "<leader>q", vim.diagnostic.setloclist, { buffer = ev.buf, desc = "Open diagnostics list" })

        if client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
            vim.keymap.set("n", "<leader>th", function()
                local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
                vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = 0 })
                vim.notify("Inlay Hints " .. (is_enabled and "Disabled" or "Enabled"))
            end, { desc = "Toggle Inlay Hints" })
        end
        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, {})
        end
        if client:supports_method("textDocument/formatting") then
            vim.api.nvim_buf_create_user_command(ev.buf, "Fmt", function()
                vim.lsp.buf.format({
                    async = true,
                    id = client.id,
                })
            end, {
                desc = "Format buffer or visual selection",
                range = true
            })
        end
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    desc = 'Use Tree-sitter for indentation if a parser is available',
    callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match) or args.match
        local has_parser, _ = pcall(vim.treesitter.get_parser, args.buf, lang)

        if has_parser then
            vim.bo[args.buf].indentexpr = "v:lua.vim.treesitter.indentexpr()"
        end
    end,
})
