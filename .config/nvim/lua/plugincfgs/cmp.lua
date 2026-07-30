return {
	keymap = {
		preset = "none",
		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
		["<C-n>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
		["<Up>"] = {},
		["<Down>"] = {},
	},
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
		kind_icons = {
			-- Copilot = "",
			Text = "󰉿",
			Method = "󰊕",
			Function = "󰊕",
			Constructor = "󰒓",
			Field = "󰜢",
			Variable = "󰆦",
			Property = "󰖷",
			Class = "󱡠",
			Interface = "󱡠",
			Struct = "󱡠",
			Module = "󰅩",
			Unit = "󰪚",
			Value = "󰦨",
			Enum = "󰦨",
			EnumMember = "󰦨",
			Keyword = "󰻾",
			Constant = "󰏿",
			Snippet = "󱄽",
			Color = "󰏘",
			File = "󰈔",
			Reference = "󰬲",
			Folder = "󰉋",
			Event = "󱐋",
			Operator = "󰪚",
			TypeParameter = "󰬛",
		},
	},
	completion = {
		trigger = {
			prefetch_on_insert = true,
			show_on_keyword = true,
			show_on_trigger_character = true,
		},
		keyword = { range = "full" },
		list = { selection = { preselect = true, auto_insert = false } },
		menu = {
			auto_show = true,
			border = "none",
			draw = {
				columns = {
					{ "kind_icon" },
					{ "label",    "label_description", gap = 1 },
					{ "kind" },
				},
				treesitter = { "lsp" },
			},
		},
		documentation = {
			auto_show = false,
			auto_show_delay_ms = 2000,
			treesitter_highlighting = true,
			window = {
				max_height = 20,
				border = nil,
				winblend = 0,
				winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
				scrollbar = false,
				direction_priority = {
					menu_north = { "e", "w", "n", "s" },
					menu_south = { "e", "w", "s", "n" },
				},
			},
		},
		ghost_text = { enabled = false, show_with_menu = true },
	},
	sources = {
		-- Default priority sequence (AI -> LSP -> Snippets -> Path -> Omni -> Buffer)
		-- default = { "supermaven", "copilot", "lsp", "snippets", "path", "omni", "buffer" },
		default = { "lsp", "snippets", "path", "buffer" },
		providers = {
			-- Priority 1: AI Primary (Fastest)
			-- supermaven = {
			-- 	name = "supermaven",
			-- 	module = "blink-cmp-supermaven",
			-- 	score_offset = 100,
			-- 	async = true,
			-- },
			-- -- Priority 2: AI Secondary (Deep logic)
			-- copilot = {
			-- 	name = "copilot",
			-- 	module = "blink-cmp-copilot",
			-- 	score_offset = 95,
			-- 	async = true,
			-- },
			lsp = {
				name = "LSP",
				module = "blink.cmp.sources.lsp",
				score_offset = 90,
				async = true,
			},
			snippets = {
				name = "Snippets",
				module = "blink.cmp.sources.snippets",
				score_offset = 80,
				async = true,
			},
			path = {
				name = "Path",
				module = "blink.cmp.sources.path",
				opts = {
					get_cwd = function()
						return vim.fn.getcwd()
					end,
				},
				score_offset = 30,
			},
			omni = {
				name = "Omni",
				score_offset = 10,
			},
			buffer = {
				name = "Buffer",
				module = "blink.cmp.sources.buffer",
				score_offset = 0,
			},
		},
	},

	signature = { enabled = true },
	cmdline = {
		completion = {
			menu = { auto_show = true },
			list = { selection = { preselect = false } },
		},
		keymap = {
			preset = "none",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<C-Space>"] = { "show", "fallback" },
			["<Up>"] = {},
			["<Down>"] = {},
		},
	},
}
