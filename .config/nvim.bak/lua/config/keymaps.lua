local map = vim.keymap.set


-- Handle soft/wrapped lines gracefully unless a count is given (e.g., 5j)
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Clear search highlights on escape
map("n", "<Esc>", "<cmd>:noh<CR>", { desc = "Clear search highlight" })

-- Disable arrow keys (Optional hard mode - currently commented out)
-- map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')


-- Move focus between window splits
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Create window splits
-- Vertical Split
map("n", "<leader>|", "<cmd>vsplit<CR>", { desc = "Split Window Vertically" })

-- Horizontal Split
map("n", "<leader>-", "<cmd>split<CR>", { desc = "Split Window Horizontally" })
-- Resize window splits using Ctrl + Arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- ============================================================================
-- 3. Text Editing & Manipulation
-- ============================================================================

-- Move lines up/down in Normal, Insert, and Visual modes (Alt + j/k)
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Line Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Line Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Line Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Line Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Block Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Block Up" })

-- Automatic bracket completion pairs (Currently commented out)
-- map("i", "`", "``<left>")
-- map("i", '"', '""<left>')
-- map("i", "(", "()<left>")
-- map("i", "[", "[]<left>")
-- map("i", "{", "{}<left>")
-- map("i", "{<CR>", "{}<left><CR><Esc>O")
-- map("i", "<", "<><left>")

-- ============================================================================
-- 4. Buffer Management
-- ============================================================================

map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete Buffer" })

-- ============================================================================
-- 5. File Explorer & Diagnostics
-- ============================================================================

-- Netrw default explorer (Currently commented out)
-- map("n", "<leader>e", ":Ex<CR>", {})

-- Open Oil.nvim file manager in parent directory
map("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Open Neovim's built-in diagnostic list
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic Quickfix list' })

-- ============================================================================
-- 6. Tab Workspaces
-- ============================================================================

map("n", "tn", ":tabnew<CR>", { desc = "Create new empty tab" })
map("n", "te", ":tabedit ", { desc = "Edit file in new tab" })
map("n", "th", ":tabprevious<CR>", { desc = "Go to previous tab" })
map("n", "tl", ":tabnext<CR>", { desc = "Go to next tab" })
map("n", "tc", ":tabclose<CR>", { desc = "Close current tab" })

-- ============================================================================
-- 7. Fzf-lua (Fuzzy Finder)
-- ============================================================================

-- Search files and content
map("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "Find Files", silent = true })
map("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>", { desc = "Recent Files", silent = true })
map("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", { desc = "Live Grep (Workspace)", silent = true })
map("n", "<leader>fw", "<cmd>FzfLua grep_cword<CR>", { desc = "Grep Word Under Cursor", silent = true })
map("v", "<leader>fw", "<cmd>FzfLua grep_visual<CR>", { desc = "Grep Visual Selection", silent = true })
map("n", "<leader>fR", "<cmd>FzfLua resume<CR>", { desc = "Resume Last Picker", silent = true })

-- Search Neovim metadata and contexts
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
map("n", "gR", "<cmd>FzfLua lsp_references<CR>", { desc = "List all references" })
map("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
