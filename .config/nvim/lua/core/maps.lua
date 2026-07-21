local map = vim.keymap.set

-- buffer stuff
map("n", "<leader>bn", ":bnext<CR>", { desc = "next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "prev buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete Buffer" })

--layout
map("n", "s\\", "<cmd>vsplit<CR>", { desc = "split vertically" })
map("n", "s-", "<cmd>split<CR>", { desc = "split horizontally" })

map("n", "<Esc>", "<Cmd>nohlsearch<CR><Esc>", { noremap = true, silent = true })
map("n", "K", function()
	vim.lsp.buf.hover()
end, { noremap = true, silent = true, desc = "LSP hover" })

-- better motion
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

map("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "Find Files", silent = true })
map("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>", { desc = "Recent Files", silent = true })
map("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", { desc = "Live Grep (Workspace)", silent = true })
map("n", "<leader>fw", "<cmd>FzfLua grep_cword<CR>", { desc = "Grep Word Under Cursor", silent = true })
map("v", "<leader>fw", "<cmd>FzfLua grep_visual<CR>", { desc = "Grep Visual Selection", silent = true })
map("n", "<leader>fR", "<cmd>FzfLua resume<CR>", { desc = "Resume Last Picker", silent = true })

map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "Find Buffers", silent = true })
map("n", "<leader>f/", "<cmd>FzfLua blines<CR>", { desc = "Fuzzy Find in Current Buffer", silent = true })
map("n", "<leader>fl", "<cmd>FzfLua lines<CR>", { desc = "Fuzzy Find in All Open Buffers", silent = true })
map("n", "<leader>fm", "<cmd>FzfLua marks<CR>", { desc = "Find Marks", silent = true })
map("n", "<leader>f\"", "<cmd>FzfLua registers<CR>", { desc = "Find Registers", silent = true })
map("n", "<leader>fk", "<cmd>FzfLua keymaps<CR>", { desc = "Find Keymaps", silent = true })
map("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>", { desc = "Find Help Tags", silent = true })
map("n", "<leader>fc", "<cmd>FzfLua command_history<CR>", { desc = "Command History", silent = true })

map("n", "<leader>gs", "<cmd>FzfLua git_status<CR>", { desc = "Git Status", silent = true })
map("n", "<leader>gc", "<cmd>FzfLua git_commits<CR>", { desc = "Git Commits", silent = true })
map("n", "<leader>gb", "<cmd>FzfLua git_branches<CR>", { desc = "Git Branches", silent = true })

map("n", "<leader>fa", function()
	require("aerial").fzf_lua_picker({ profile = "ivy" })
end, { noremap = true, silent = true, desc = "Fzf Aerial Outline" })

map("n", "<leader>tp", function()
	require("lua.plugincfgs.todo_comments").jump_next()
end, { noremap = true, silent = true, desc = "Next TODO Comment" })

map("n", "<leader>tn", function()
	require("lua.plugincfgs.todo_comments").jump_prev()
end, { noremap = true, silent = true, desc = "Previous TODO Comment" })
