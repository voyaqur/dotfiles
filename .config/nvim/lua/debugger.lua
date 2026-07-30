-- 1. Plugin Declarations
vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/igorlfs/nvim-dap-view" },
	-- { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
	-- { src = "https://github.com/Weissle/persistent-breakpoints.nvim" },
	-- { src = "https://github.com/LiadOz/nvim-dap-repl-highlights" },
	-- {src = "https://github.com/nvim-treesitter/nvim-treesitter"}
	{ src = "https://github.com/Vigemus/iron.nvim" },
	{ src = "https://codeberg.org/Jorenar/nvim-dap-disasm" }
})
local dap = require("dap")
local dap_view = require("dap-view")
local map = vim.keymap.set

-- 2. Signs
local signs = {
	DapBreakpoint = { text = "", texthl = "DiagnosticError" },
	DapBreakpointCondition = { text = "", texthl = "DiagnosticWarn" },
	DapLogPoint = { text = "", texthl = "DiagnosticInfo" },
	DapStopped = { text = "󰁕", texthl = "DiagnosticHint", linehl = "DapStoppedLine", numhl = "DapStoppedLine" },
	DapBreakpointRejected = { text = "", texthl = "DiagnosticError" },
}
for type, icon in pairs(signs) do
	vim.fn.sign_define(type, icon)
end
vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
require("dap-disasm").setup({
	dapui_register = false,
	dapview_register = true,
	dapview = {
		keymap = "D",
		label = "Disassembly",
		short_label = "󰒓 [D]",
	},
	winbar = {
		enabled = true,
		labels = {
			step_into = "Step Into",
			step_over = "Step Over",
			step_back = "Step Back",
		},
		order = {
			"step_into", "step_over", "step_back"
		}
	},
	sign = "DapStopped",
	ins_before_memref = 16,
	ins_after_memref = 16,
	columns = {
		"address",
		"instructionBytes",
		"instruction",
	},
})
dap_view.setup({
	auto_toggle = true,
	winbar = {
		show = true,
		sections = { "scopes", "watches", "exceptions", "breakpoints", "threads", "repl", "console", "disassembly" },
		default_section = "scopes",
	},
})

-- 3. Inline virtual text: shows variable values next to the line as you step (RustRover/CLion-style inline eval)
-- require("nvim-dap-virtual-text").setup({
-- 	enabled = true,
-- 	virt_text_pos = "eol",
-- 	show_stop_reason = true,
-- 	commented = true, -- prefix with comment string so it doesn't look like real code
-- })
--
-- -- 4. REPL syntax highlighting
-- require("nvim-dap-repl-highlights").setup()


local function find_codelldb()
	local candidates = {
		vim.fn.expand("~/.vscode-oss/extensions/vadimcn.vscode-lldb-*/adapter/codelldb"),
		vim.fn.expand("~/.vscode/extensions/vadimcn.vscode-lldb-*/adapter/codelldb"),
		vim.fn.expand(
			"~/.var/app/com.vscodium.codium/data/vscodium/extensions/vadimcn.vscode-lldb-*/adapter/codelldb"
		),
	}
	for _, pattern in ipairs(candidates) do
		local matches = vim.fn.glob(pattern, false, true)
		if #matches > 0 then
			return matches[1]
		end
	end
	return nil
end

local codelldb_path = find_codelldb()
local lldb_dap_path = vim.fn.exepath("lldb-dap")
if lldb_dap_path == "" then
	lldb_dap_path = "/usr/bin/lldb-dap"
end

if codelldb_path and vim.fn.executable(codelldb_path) == 1 then
	dap.adapters.lldb = function(callback)
		local port = 13000 + math.random(0, 999)
		vim.fn.jobstart({ codelldb_path, "--port", tostring(port) })
		vim.defer_fn(function()
			callback({
				type = "server",
				host = "127.0.0.1",
				port = port,
				executable = { command = codelldb_path },
			})
		end, 300)
	end
	vim.notify("DAP: using codelldb", vim.log.levels.INFO)
elseif vim.fn.executable(lldb_dap_path) == 1 then
	dap.adapters.lldb = { type = "executable", command = lldb_dap_path, name = "lldb-dap" }
	vim.notify("DAP: codelldb not found, using lldb-dap", vim.log.levels.WARN)
else
	dap.adapters.lldb = { type = "executable", command = "/usr/bin/lldb", name = "lldb" }
	vim.notify("DAP: codelldb/lldb-dap not found, falling back to lldb", vim.log.levels.WARN)
end

-- 7. Configurations (C / C++)
local last_binary, last_args, last_env, last_cwd = nil, nil, nil, nil

local function pick_binary()
	if last_binary then
		if vim.fn.confirm("Reuse last binary: " .. last_binary .. "?", "&Yes\n&No", 1) == 1 then
			return last_binary
		end
	end
	last_binary = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
	return last_binary
end

local function pick_args()
	last_args = vim.fn.input("Program args: ", last_args or "")
	return vim.split(last_args, " ", { trimempty = true })
end

local function pick_env()
	local input = vim.fn.input("Env vars (KEY=val,KEY2=val2): ", last_env or "")
	last_env = input
	if input == "" then
		return nil
	end
	local env = {}
	for pair in input:gmatch("[^,]+") do
		local k, v = pair:match("^%s*(.-)%s*=%s*(.-)%s*$")
		if k then
			env[k] = v
		end
	end
	if next(env) == nil then
		return vim.empty_dict()
	end
	return env
end

local function pick_cwd()
	last_cwd = vim.fn.input("cwd: ", last_cwd or vim.fn.getcwd(), "dir")
	return last_cwd ~= "" and last_cwd or vim.fn.getcwd()
end

local cpp_config = {
	{
		name = "Launch (build via <F9> first)",
		type = "lldb",
		request = "launch",
		program = pick_binary,
		cwd = pick_cwd,
		env = pick_env,
		stopOnEntry = false,
		args = pick_args,
		runInTerminal = false,
	},
	{
		name = "Launch (stop on entry)",
		type = "lldb",
		request = "launch",
		program = pick_binary,
		cwd = pick_cwd,
		env = pick_env,
		stopOnEntry = true,
		args = pick_args,
	},
	{
		name = "Attach to Process",
		type = "lldb",
		request = "attach",
		pid = require("dap.utils").pick_process,
		cwd = "${workspaceFolder}",
	},
	{
		name = "Attach to Process (wait for launch)",
		type = "lldb",
		request = "attach",
		pid = require("dap.utils").pick_process,
		waitFor = true,
		cwd = "${workspaceFolder}",
	},
}
dap.configurations.cpp = cpp_config
dap.configurations.c = cpp_config
-- dap.configurations.rust = cpp_config

-- 8. Exception breakpoints (catch thrown C++ exceptions / signals like SIGSEGV/SIGABRT)
dap.defaults.fallback.exception_breakpoints = { "throw", "catch" }

-- 9. Compile-then-debug helper with debug/release toggle
local build_mode = "debug" -- toggle with <leader>dm

local function compile_flags()
	if build_mode == "debug" then
		return "-std=c++14 -O2 -g -Wall -Wextra -fsanitize=address,undefined"
	else
		return "-std=c++14 -O2 -DNDEBUG -Wall -Wextra"
	end
end

local function compile_and_set_binary()
	local file = vim.fn.expand("%:p")
	local out = vim.fn.expand("%:p:r")
	local cmd = string.format('g++ %s -o "%s" "%s"', compile_flags(), out, file)
	vim.notify("Compiling (" .. build_mode .. "): " .. cmd, vim.log.levels.INFO)
	vim.fn.jobstart(cmd, {
		on_exit = function(_, code)
			if code == 0 then
				last_binary = out
				vim.notify("Compiled OK -> " .. out, vim.log.levels.INFO)
			else
				vim.notify("Compile failed", vim.log.levels.ERROR)
			end
		end,
		stderr_buffered = true,
		on_stderr = function(_, data)
			for _, line in ipairs(data or {}) do
				if line ~= "" then
					vim.notify(line, vim.log.levels.ERROR)
				end
			end
		end,
	})
end

map("n", "<F9>", compile_and_set_binary, { desc = "Compile (current mode) with debug symbols" })
map("n", "<leader>dm", function()
	build_mode = (build_mode == "debug") and "release" or "debug"
	vim.notify("Build mode: " .. build_mode, vim.log.levels.INFO)
end, { desc = "Toggle Debug/Release Build Mode" })

-- 10. Native Function Keys
map("n", "<F5>", dap.continue, { desc = "DAP Continue" })
map("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
map("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
map("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })

require("which-key").add({ "<leader>d", group = "Debug (DAP)", icon = "󰃤 " })

-- Breakpoints (routed through persistent-breakpoints so they're saved automatically)
-- map("n", "<leader>db", persistent_bp.toggle_breakpoint, { desc = "Toggle Breakpoint" })
-- map("n", "<leader>dB", function()
-- 	persistent_bp.set_conditional_breakpoint()
-- end, { desc = "Conditional Breakpoint" })
map("n", "<leader>dh", function()
	local count = tonumber(vim.fn.input("Hit count: "))
	if count then
		dap.set_breakpoint(nil, tostring(count), nil)
	end
end, { desc = "Hit-Count Breakpoint" })
map("n", "<leader>dlp", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log message: "))
end, { desc = "Log Point" })
-- map("n", "<leader>dX", persistent_bp.clear_all_breakpoints, { desc = "Clear All Breakpoints" })

-- Execution Control
map("n", "<leader>dc", dap.continue, { desc = "Continue / Start" })
map("n", "<leader>di", dap.step_into, { desc = "Step Into" })
map("n", "<leader>do", dap.step_over, { desc = "Step Over" })
map("n", "<leader>dO", dap.step_out, { desc = "Step Out" })
map("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to Cursor" })
map("n", "<leader>dr", dap.restart, { desc = "Restart Session" })
map("n", "<leader>dq", function()
	dap.terminate()
	dap_view.close()
end, { desc = "Terminate Session" })
map("n", "<leader>dj", dap.down, { desc = "Down Stack Frame" })
map("n", "<leader>dk", dap.up, { desc = "Up Stack Frame" })

-- Inspection & UI
map("n", "<leader>dv", dap_view.toggle, { desc = "Toggle DAP View UI" })
map({ "n", "v" }, "<leader>de", require("dap.ui.widgets").hover, { desc = "Evaluate/Hover Value" })
map({ "n", "v" }, "<leader>dw", dap_view.add_expr, { desc = "Add Watch Expression" })
map("n", "<leader>dR", dap.repl.toggle, { desc = "Toggle REPL" })
-- Rustaceanvim Targets
-- map("n", "<leader>dt", "<cmd>RustLsp testables<cr>", { desc = "Rust Testables" })
-- map("n", "<leader>dD", "<cmd>RustLsp debuggables<cr>", { desc = "Rust Debuggables" })

-- 11. fzf-lua picker for breakpoint list (skips if fzf-lua isn't loaded)
local has_fzf, fzf = pcall(require, "fzf-lua")
if has_fzf then
	map("n", "<leader>dL", function()
		local bps = require("dap.breakpoints").get()
		local items = {}
		for bufnr, buf_bps in pairs(bps) do
			local fname = vim.api.nvim_buf_get_name(bufnr)
			for _, bp in ipairs(buf_bps) do
				table.insert(items, string.format("%s:%d", fname, bp.line))
			end
		end
		fzf.fzf_exec(items, {
			actions = {
				["default"] = function(selected)
					local file, line = selected[1]:match("^(.*):(%d+)$")
					vim.cmd("edit " .. file)
					vim.api.nvim_win_set_cursor(0, { tonumber(line), 0 })
				end,
			},
		})
	end, { desc = "List/Jump Breakpoints (fzf)" })
end
