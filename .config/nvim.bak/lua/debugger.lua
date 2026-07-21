local map = vim.keymap.set

-- Load packages natively
vim.pack.add({
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/rcarriga/nvim-dap-ui" },
    { src = "https://github.com/nvim-neotest/nvim-nio" }, -- dependency
})

local dap, dapui = require("dap"), require("dapui")
map("n", "<leader>db", function() require('dap').toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
dapui.setup()

-- Auto open/close UI hooks
dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

-- Adapter Configuration
dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
    }
}

--- Clean action wrapper helper to ensure mappings execute correctly on-press
local function dap_action(callback)
    return function()
        callback()
    end
end

-- Keymaps (Fixed syntax errors and clean execution blocks)
map("n", "<F5>", dap_action(function() dap.continue() end), { desc = "Debug: Start/Continue" })
map("n", "<leader>b", dap_action(function() dap.toggle_breakpoint() end), { desc = "Debug: Toggle Breakpoint" })

map("n", "<leader>B", dap_action(function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end), { desc = "Debug: Set Conditional Breakpoint" })
map("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
map("n", "<F10>", dap_action(function() dap.step_over() end), { desc = "Debug: Step Over" })
map("n", "<F11>", dap_action(function() dap.step_into() end), { desc = "Debug: Step Into" })
map("n", "<F12>", dap_action(function() dap.step_out() end), { desc = "Debug: Step Out" })

map("n", "<leader>du", function()
    dapui.toggle()
end, { desc = "Debug: Toggle UI" })
