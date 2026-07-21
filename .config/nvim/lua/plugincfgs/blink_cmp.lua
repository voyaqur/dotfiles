return {
	keymap = { preset = "super-tab" },
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
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
				components = {
					kind_icon = {
						text = function(ctx)
							-- return require('lspkind').symbol_map[ctx.kind] or ''
							return ctx.kind_icon -- Fallback so blink doesn't throw a nil error
						end,
					},
				},
			},
		},
		documentation = {
			auto_show = false,
			auto_show_delay_ms = 2000,
			treesitter_highlighting = true,
		},
		ghost_text = { enabled = true },
	},

	-- ✅ FIXED: Changed 'source' -> 'sources'
	sources = {
		-- ✅ FIXED: Kept valid completion sources for normal buffers
		default = { "lsp", "path", "buffer", "snippets" },
		providers = {
			lsp = {},
			path = {
				opts = {
					get_cwd = function()
						return vim.fn.getcwd()
					end,
				},
			},
			buffer = {},
			snippets = {},
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
