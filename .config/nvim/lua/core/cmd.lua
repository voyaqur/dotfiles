local cmd = vim.api.nvim_create_user_command

cmd('GetEnv', function()
	-- Your custom Lua logic goes here
	local msg = "Buffer: " .. vim.fn.expand('%:t') .. " | LSP: Active"
	vim.notify(msg, vim.log.levels.INFO, { title = "Neovim Env" })
end, {})

cmd('Log', function(opts)
	vim.notify(opts.args, vim.log.levels.WARN, { title = "User Log" })
end, { nargs = '+', -- Declares that the command requires 1 or more arguments
})


