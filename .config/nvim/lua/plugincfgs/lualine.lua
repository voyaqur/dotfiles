-- Custom Macro Recording Indicator
local function macro_recording()
	local reg = vim.fn.reg_recording()
	if reg ~= "" then
		return "󰑋 REC @" .. reg
	end
	return ""
end

return {
	options = {
		theme = "16color",
		-- Match your powerline chevrons exactly
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		globalstatus = true,
		icons_enabled = true,
	},
	sections = {
		-- 1. BOLD SINGLE LETTER MODE
		lualine_a = {
			{
				"mode",
				fmt = function(str)
					return str:sub(1, 1)
				end,
				gui = "bold",
			},
		},

		-- 2. HEAVY GIT METRICS
		lualine_b = {
			{
				"diff",
				symbols = { added = "+", modified = "~", removed = "-" },
				colored = true,
				source = function()
					local gitsigns = vim.b.gitsigns_status_dict
					if gitsigns then
						return {
							added = gitsigns.added,
							modified = gitsigns.changed,
							removed = gitsigns.removed
						}
					end
				end,
				color = { bg = '#21011f' }
			},
			{ "branch", icon = "", color = { bg = '#21011f' }, gui = "bold" },
		},

		-- 3. ACTIVE FILE & MACROS
		lualine_c = {

			{ "filetype", icon_only = true, },
			{
				"filename",
				file_status = true,
				path = 1, -- Relative path (e.g. lua/plugincfgs/lualine.lua)
				symbols = {
					modified = "●",
					readonly = "",
					unnamed = "[No Name]",
					newfile = ''
				},
			},
			{
				macro_recording,
				color = { fg = "#e06c75", gui = "bold" },
			},
		},

		-- 4. LSP & DIAGNOSTICS
		lualine_x = {
			{
				-- Active LSP Server Name
				function()
					local clients = vim.lsp.get_clients({ bufnr = 0 })
					if #clients == 0 then
						return ""
					end
					return " " .. clients[1].name
				end,
				color = { fg = "#61afef" },
			},
		},

		lualine_y = {
			{
				"diagnostics",
				color = { bg = '#0a090a' },
				sources = { "nvim_diagnostic" },
				symbols = {
					error = "󰅚 ",
					warn  = "󰀪 ",
					hint  = "󰌶 ",
					info  = "󰋽 ",
				},
			},
		},

		-- 6. MATCHES @ ARCH POSITION (CURSOR LOCATION)
		--
		lualine_z = {
			{ "location", gui = 'bold' },
			{ "progress" },
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
}
