-- 1. Plugin Declarations
vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/igorlfs/nvim-dap-view" },
})

local dap = require("dap")
local dap_view = require("dap-view")
local signs = {
	DapBreakpoint = { text = "", texthl = "DiagnosticError" },
	DapBreakpointCondition = { text = "", texthl = "DiagnosticWarn" },
	DapLogPoint = { text = "", texthl = "DiagnosticInfo" },
	DapStopped = { text = "󰁕", texthl = "DiagnosticHint", linehl = "DapStoppedLine", numhl = "DapStoppedLine" },
	DapBreakpointRejected = { text = "", texthl = "DiagnosticError" },
}

for type, icon in pairs(signs) do
	vim.fn.sign_define(type, icon)
end
vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
dap_view.setup({
	auto_toggle = true,
	winbar = {
		show = true,
		sections = { "scopes", "watches", "exceptions", "breakpoints", "threads" },
		default_section = "scopes",
	},
})

-- 4. Adapters & Configurations (C / C++)
local lldb_path = vim.fn.exepath("lldb-dap")
if lldb_path == "" then
	lldb_path = "/usr/bin/lldb-dap"
end

dap.adapters.lldb = {
	type = "executable",
	command = lldb_path,
	name = "lldb",
}

local cpp_config = {
	{
		name = "Launch Binary",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
	{
		name = "Attach to Process",
		type = "lldb",
		request = "attach",
		pid = require("dap.utils").pick_process,
		cwd = "${workspaceFolder}",
	},
}

dap.configurations.cpp = cpp_config
dap.configurations.c = cpp_config


-- Native Function Keys
local map = vim.keymap.set
map("n", "<F5>", dap.continue, { desc = "DAP Continue" })
map("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
map("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
map("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })

require("which-key").add({ "<leader>d", group = "Debug (DAP)", icon = "󰃤 " })
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
map("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Condition: "))
end, { desc = "Conditional Breakpoint" })
map("n", "<leader>dlp", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log message: "))
end, { desc = "Log Point" })
map("n", "<leader>dX", dap.clear_breakpoints, { desc = "Clear All Breakpoints" })

-- Execution Control
map("n", "<leader>dc", dap.continue, { desc = "Continue / Start" })
map("n", "<leader>di", dap.step_into, { desc = "Step Into" })
map("n", "<leader>do", dap.step_over, { desc = "Step Over" })
map("n", "<leader>dO", dap.step_out, { desc = "Step Out" })
map("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to Cursor" })
map("n", "<leader>dr", dap.restart, { desc = "Restart Session" })
map("n", "<leader>dq", dap.terminate, { desc = "Terminate Session" })

-- Inspection & UI
map("n", "<leader>dv", dap_view.toggle, { desc = "Toggle DAP View UI" })
map({ "n", "v" }, "<leader>dh", require("dap.ui.widgets").hover, { desc = "Hover Value" })
map({ "n", "v" }, "<leader>dw", dap_view.add_expr, { desc = "Add Watch Expression" })
map("n", "<leader>dR", dap.repl.toggle, { desc = "Toggle REPL" })

-- Rustaceanvim Targets
map("n", "<leader>dt", "<cmd>RustLsp testables<cr>", { desc = "Rust Testables" })
map("n", "<leader>dD", "<cmd>RustLsp debuggables<cr>", { desc = "Rust Debuggables" })
