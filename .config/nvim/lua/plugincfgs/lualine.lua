-- Cuwrom Macro Recording Indicator
local function macro_recording()
	local reg = vim.fn.reg_recording()
	if reg ~= "" then
		return "󰑋 REC @" .. reg
	end
	return ""
end

-- geist_noir palette (mirrors lua/lush_theme/geist_noir.lua)
-- keep these two in sync if you ever tweak the colorscheme's accents.
local c = {
	bg_true    = "#000000",
	bg_raised  = "#0a0a0a",
	gray_100   = "#0a0a0a",
	gray_400   = "#2e2e2e",
	gray_500   = "#454545",
	gray_600   = "#878787",
	gray_900   = "#a1a1a1",
	gray_1000  = "#ededed",
	blue_700   = "#004899",
	blue_900   = "#0052b3",
	green_700  = "#266333",
	green_900  = "#30743d",
	purple_700 = "#532a78",
	purple_900 = "#683993",
	red_900    = "#a02227",
	teal_900   = "#078e81",
}

-- Custom pitch-black monochrome theme, built from the geist_noir accents
local custom_theme = {
	normal = {
		a = { fg = c.gray_1000, bg = c.blue_700, gui = "bold" }, -- Blue
		b = { fg = c.gray_1000, bg = c.gray_100 },
		c = { fg = c.gray_600, bg = c.bg_true },
		x = { fg = c.gray_600, bg = c.bg_true },
		y = { fg = c.gray_1000, bg = c.bg_raised },
		z = { fg = c.gray_1000, bg = c.blue_700, gui = "bold" },
	},
	insert = { a = { fg = c.gray_1000, bg = c.green_700, gui = "bold" } },   -- Green
	visual = { a = { fg = c.gray_1000, bg = c.purple_700, gui = "bold" } }, -- Purple
	replace = { a = { fg = c.gray_1000, bg = c.red_900, gui = "bold" } },  -- Red
	command = { a = { fg = c.gray_1000, bg = c.teal_900, gui = "bold" } },  -- White
	inactive = {
		a = { fg = c.gray_500, bg = c.bg_true },
		b = { fg = c.gray_500, bg = c.bg_true },
		c = { fg = c.gray_500, bg = c.bg_true },
	},
}

return {
	options = {
		theme = custom_theme,
		-- Powerline chevrons matching your tmux bar
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		globalstatus = true,
		icons_enabled = true,
	},
	sections = {
		-- 1. BOLD SINGLE LETTER MODE (COLORFUL)
		lualine_a = {
			{
				"mode",
				fmt = function(str)
					return str:sub(1, 1)
				end,
				gui = "bold",
			},
		},
		-- 2. MONOCHROME GIT METRICS
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
							removed = gitsigns.removed,
						}
					end
				end,
				color = { fg = c.gray_600, bg = c.gray_100 },
			},
			{ "branch", icon = "", color = { fg = c.gray_1000, bg = c.gray_100, gui = "bold" } },
		},
		-- 3. ACTIVE FILE & MACROS (PITCH BLACK BACKGROUND)
		lualine_c = {
			{ "filetype", icon_only = true },
			{
				"filename",
				file_status = true,
				path = 1,
				symbols = {
					modified = "●",
					readonly = "",
					unnamed = "[No Name]",
					newfile = "",
				},
				color = { fg = c.gray_1000, bg = c.bg_true },
			},
			{
				macro_recording,
				color = { fg = c.red_900, bg = c.bg_true, gui = "bold" },
			},
		},
		-- 4. LSP SERVER
		lualine_x = {
			{
				function()
					local clients = vim.lsp.get_clients({ bufnr = 0 })
					if #clients == 0 then
						return ""
					end
					return " " .. clients[1].name
				end,
				color = { fg = c.teal_900, bg = c.bg_true },
			},
		},
		-- 5. DIAGNOSTICS
		lualine_y = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = {
					error = "󰅚 ",
					warn  = "󰀪 ",
					hint  = "󰌶 ",
					info  = "󰋽 ",
				},
				colored = false,
				color = { fg = c.gray_600, bg = c.bg_raised },
			},
		},
		-- 6. BLUE LOCATION BLOCK
		lualine_z = {
			{ "location", gui = "bold" },
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
