local M = {}
---@pragma private

---@param name string The module name to require and setup.
---@param ev string|table|nil The event(s) to defer loading on. If nil, loads immediately.
---@param pt string|table|nil The pattern(s) for the autocmd event. Defaults to "*".
---@param cfg table|nil Configuration table passed directly to the plugin's `.setup()` function.
---@param start function|nil Callback executed immediately before the plugin is required.
---@param later function|nil Callback executed immediately after the plugin is setup.
function M.load(name, ev, pt, cfg, start, later)
	local function loader()
		if type(start) == "function" then
			start()
		end
		require(name).setup(cfg or {})
		if type(later) == "function" then
			later()
		end
	end
	if not ev then
		loader()
		return
	end
	local lazy = vim.api.nvim_create_augroup("Lazy_" .. name, { clear = true })
	vim.api.nvim_create_autocmd(ev, {
		group = lazy,
		once = true,
		pattern = pt or "*",
		callback = function()
			loader()
			vim.api.nvim_del_augroup_by_id(lazy)
		end,
	})
end

return M
