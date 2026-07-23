local VRC = "vimrc_vimrc"
local api = vim.api
local autocmd = api.nvim_create_autocmd
api.nvim_create_augroup(VRC, { clear = true })

autocmd("InsertEnter", {
	group = VRC,
	pattern = "*",
	callback = function()
		vim.opt_local.relativenumber = false
	end,
})

autocmd("InsertLeave", {
	group = VRC,
	pattern = "*",
	callback = function()
		vim.opt_local.relativenumber = true
	end,
})

autocmd({ "TextYankPost" }, {
	group = VRC,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = (vim.fn.hlexists("HighlightedyankRegion") > 0 and "HighlightedyankRegion" or "Visual"),
			timeout = 150,
		})
	end,
	once = false,
})

autocmd({ "TextYankPost" }, {
	group = VRC,
	pattern = "*",
	callback = function()
		if vim.v.event.operator == "y" and vim.g.keep_cursor_yank then
			api.nvim_win_set_cursor(0, vim.g.keep_cursor_yank)
			vim.g.keep_cursor_yank = nil
		end
	end,
	once = false,
})

autocmd({ "ModeChanged" }, {
	group = VRC,
	pattern = "*",
	callback = function()
		local mode = api.nvim_get_mode().mode
		if mode == "s" then
			local key = api.nvim_replace_termcodes("<C-r>_", true, false, true)
			api.nvim_feedkeys(key, "s", false)
		end
	end,
	once = false,
})

autocmd({ "ModeChanged" }, {
	group = VRC,
	pattern = "*:s",
	callback = function()
		vim.o.clipboard = ""
	end,
	once = false,
})

autocmd({ "ModeChanged" }, {
	group = VRC,
	pattern = "s:*",
	callback = function()
		if vim.fn.has("clipboard") == 1 then
			vim.o.clipboard = "unnamedplus,unnamed"
		end
	end,
	once = false,
})

autocmd({ "WinEnter", "FocusGained" }, {
	group = VRC,
	pattern = "*",
	callback = function()
		if vim.api.nvim_buf_get_name(0) ~= "[Command Line]" then
			vim.cmd.checktime()
		end
	end,
	once = false,
})

autocmd({ "BufWritePre" }, {
	group = VRC,
	pattern = "*",
	callback = function()
		local function auto_mkdir(dir, force)
			if not dir or string.len(dir) == 0 then
				return
			end
			local stats = vim.uv.fs_stat(dir)
			local is_directory = (stats and stats.type == "directory") or false
			if string.match(dir, "^%w%+://") or is_directory or string.match(dir, "^suda:") then
				return
			end
			if not force then
				vim.fn.inputsave()
				local result = vim.fn.input(string.format('"%s" does not exist. Create? [y/N]', dir), "")
				if string.len(result) == 0 then
					print("Canceled")
					return
				end
				vim.fn.inputrestore()
			end
			vim.fn.mkdir(dir, "p")
		end
		auto_mkdir(vim.fn.expand("<afile>:p:h"), vim.v.cmdbang)
	end,
	once = false,
})

autocmd("BufWritePre", {
	group = VRC,
	desc = "Add timestamp to backup extension",
	pattern = "*",
	callback = function()
		vim.opt.backupext = "-" .. os.date("%Y%m%d%H%M")
	end,
})


autocmd("FileType", {
	group = VRC,
	desc = "Add timestamp to backup extension",
	pattern = "rust",
	callback = function()
		require("debugger")
	end,
})
