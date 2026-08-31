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
    },
    completion = {
        trigger = {
            prefetch_on_insert = true,
            show_on_keyword = true,
            show_on_trigger_character = true,
        },
        keyword = { range = "full" },
        list = { selection = { preselect = false, auto_insert = false } },
        menu = {
            auto_show = true,
            border = "none",
            draw = {
                columns = {
                    { "kind_icon" },
                    { "label", "label_description", gap = 1 },
                    { "kind" },
                    -- { "source_name" },
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
        default = function()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if #clients > 0 then
                return { "lsp", "snippets", "path", "buffer" }
            end
            return { "snippets", "path", "buffer" }
        end,
        providers = {
            lsp = {
                name = "LSP",
                module = "blink.cmp.sources.lsp",
                score_offset = 100,
                async = true,
                min_keyword_length = 1,
            },
            snippets = {
                name = "Snippets",
                module = "blink.cmp.sources.snippets",
                score_offset = 90,
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
                score_offset = 50,
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
