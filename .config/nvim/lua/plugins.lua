local lazy = require("utils")
local map = vim.keymap.set
lazy.load("lualine", nil, nil, require("plugincfgs/lualine"))
lazy.load("gitsigns", { "BufReadPre", "BufNewFile" }, nil, require("plugincfgs/gitsigns"))
-- lazy.load("neogen", nil, nil, require("plugincfgs/neogen"))
--
lazy.load("dropbar", "FileType", { "lua", "rust", "c", "cpp" }, nil, nil, function()
    local dropbar_api = require('dropbar.api')
    vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
    vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
    vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
end)

-- lazy.load("todo-comments", { "BufReadPost", "BufNewFile" }, nil, require("plugincfgs/todo_comments"), nil, function()
-- 	map("n", "<leader>ft", "<cmd>TodoFzfLua<cr>", { noremap = true, silent = true, desc = "Fzf Search TODOs" })
-- 	map("n", "<leader>tq", "<cmd>TodoQuickFix<cr>", { noremap = true, silent = true, desc = "TODOs to QuickFix" })
-- 	map("n", "<leader>tt", "<cmd>TodoLocList<cr>", { noremap = true, silent = true, desc = "TODOs to Location List" })
-- end)

-- lazy.load("mason", nil, nil, require("plugincfgs/mason"))
-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = { "toml" },
-- 	group = vim.api.nvim_create_augroup("EmbedToml", {}),
-- 	callback = function()
-- 		require("otter").activate()
-- 	end
-- })
--
--> no indent, i use nvim autopairs now
-- lazy.load("blink.indent", "InsertEnter", "*", require("plugincfgs/blink_indent"))
-- lazy.load("blink.pairs", "InsertEnter", "*", {}, function()
--     require("blink.pairs").build():pwait(1000000)
-- end)
--

-- lazy.load("fzf-lua", "CmdUndefined", { "Fzf", "FzfLua" }, {})
lazy.load("tree-sitter-manager", nil, nil, require("plugincfgs/tree-sitter-manager"))
lazy.load("hardtime", nil, nil, {})
-- lazy.load("fidget", nil, nil, require("plugincfgs/fidget"))
lazy.load("which-key", nil, nil, {}, function()
    vim.api.nvim_set_keymap("n", "<Leader><CR>", "<Cmd>WhichKey <Leader><CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<LocalLeader><CR>", "<Cmd>WhichKey <LocalLeader><CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "f<CR>", "<Cmd>WhichKey f<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "g<CR>", "<Cmd>WhichKey g<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "[<CR>", "<Cmd>WhichKey [<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "]<CR>", "<Cmd>WhichKey ]<CR>", { noremap = true })
    require("which-key").add({
        -- { "<leader>a", group = "Aerial", icon = "󰛂 " },
        -- { "<leader>o", group = "Overseer", icon = "󰐍 " },
        { "<leader>f", group = "FzfLua", icon = "󰍉 " },
    })
end)
lazy.load("conform", "BufWritePre", "*", require("plugincfgs/conform"), nil, function()
    vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
end)
-- lazy.load("aerial", "LspAttach", nil, require("plugincfgs/aerial"), nil, function()
--     map("n", "<leader>aa", "<cmd>AerialToggle!<cr>", { noremap = true, silent = true, desc = "Toggle Aerial Window" })
--     map("n", "<leader>at", "<cmd>AerialNavToggle<cr>",
--         { noremap = true, silent = true, desc = "Toggle Aerial Nav Popup" })
--     map("n", "<leader>an", "<cmd>AerialNext<cr>", { noremap = true, silent = true, desc = "Next Aerial Symbol" })
--     map("n", "<leader>ap", "<cmd>AerialPrev<cr>", { noremap = true, silent = true, desc = "Previous Aerial Symbol" })
-- end)
--
-- -- --> I don't use this, no more
-- lazy.load("overseer", "LspAttach", nil, require("plugincfgs/overseer"), nil, function()
--     map("n", "<leader>oo", "<cmd>OverseerToggle<cr>", { noremap = true, silent = true, desc = "Toggle Task List UI" })
--     map("n", "<leader>or", "<cmd>OverseerRun<cr>", { noremap = true, silent = true, desc = "Run Task from Template" })
--     map("n", "<leader>ot", "<cmd>OverseerTaskAction<cr>", { noremap = true, silent = true, desc = "Run Task Action" })
--     map("n", "<leader>os", "<cmd>OverseerShell<cr>",
--         { noremap = true, silent = true, desc = "Run Shell Command as Task" })
-- end)
lazy.load("nvim-autopairs", "InsertEnter", "*", { map_cr = true })
lazy.load("blink.cmp", "InsertEnter", "*", require("plugincfgs.cmp"), function()
    require("blink.cmp").build():pwait()
end)
