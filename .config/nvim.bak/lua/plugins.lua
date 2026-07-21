local map = vim.keymap.set
vim.pack.add({
    { src = "https://github.com/Bekaboo/dropbar.nvim", },
    { src = "https://github.com/m4xshen/hardtime.nvim", },
    { src = "https://github.com/mrcjkb/rustaceanvim" },
    -- { src = "https://github.com/nvim-lualine/lualine.nvim", },
    { src = "https://github.com/stevearc/oil.nvim", },
    { src = "https://github.com/ibhagwan/fzf-lua", },
    { src = "https://github.com/folke/which-key.nvim", },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/folke/todo-comments.nvim" },
    { src = "https://github.com/j-hui/fidget.nvim" },
    { src = "https://github.com/chrisgrieser/nvim-lsp-endhints" },
})
-- Initialize their setups here safely inside the callback
require("gitsigns").setup()
require("todo-comments").setup()
require("fidget").setup()
require("lsp-endhints").setup {
    autoEnableHints = true,
    icons = {
        type = "󰜁 ",
        parameter = "󰏪 ",
        offspec = " ", -- hint kind not defined in official LSP spec
        unknown = " ", -- hint kind is nil
    },
    label = {
        truncateAtChars = 20,
        padding = 1,
        marginLeft = 0,
        sameKindSeparator = ", ",
    },
    extmark = {
        priority = 50,
    },

    ---Function that overrides how hints are displayed.
    ---expects as output a table for `virt_text` from `nvim_buf_set_extmark`,
    ---that is a table of string tuples (text & highlight group)
    ---To use filetype-specific formatting, get the filetype via
    ---`vim.bo[bufnr].filetype`, to conditionally use the default formatting
    ---function, use `defaultHintFormatFunc(hints)`.
    ---@type function(hints: {label: string, col: number, kind: string}[], bufnr: number, defaultHintFormatFunc: func): {[1]: string, [2]: string}[]
    hintFormatFunc = nil,
}
-- Custom function to show macro recording
local function macro_recording()
    local reg = vim.fn.reg_recording()
    if reg ~= '' then
        return '  @' .. reg
    end
    return ''
end

-- default settings



require("oil").setup({
    -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
    -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
    default_file_explorer = true,
    -- Id is automatically added at the beginning, and name at the end
    -- See :help oil-columns
    columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
    },
    -- Buffer-local options to use for oil buffers
    buf_options = {
        buflisted = false,
        bufhidden = "hide",
    },
    -- Window-local options to use for oil buffers
    win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
    },
    delete_to_trash = false,
    skip_confirm_for_simple_edits = true,
    prompt_save_on_select_new_entry = true,
    cleanup_delay_ms = 2000,
    lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = false,
    },
    constrain_cursor = "editable",
    watch_for_changes = false,
    keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<C-l>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },
    -- Set to false to disable all of the above keymaps
    use_default_keymaps = true,
    view_options = {
        -- Show files and directories that start with "."
        show_hidden = false,
        -- This function defines what is considered a "hidden" file
        is_hidden_file = function(name, bufnr)
            local m = name:match("^%.")
            return m ~= nil
        end,
        -- This function defines what will never be shown, even when `show_hidden` is set
        is_always_hidden = function(name, bufnr)
            return false
        end,
        -- Sort file names with numbers in a more intuitive order for humans.
        -- Can be "fast", true, or false. "fast" will turn it off for large directories.
        natural_order = "fast",
        -- Sort file and directory names case insensitive
        case_insensitive = false,
        sort = {
            -- sort order can be "asc" or "desc"
            -- see :help oil-columns to see which columns are sortable
            { "type", "asc" },
            { "name", "asc" },
        },
        -- Customize the highlight group for the file name
        highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
            return nil
        end,
    },
    -- Extra arguments to pass to SCP when moving/copying files over SSH
    extra_scp_args = {},
    -- Extra arguments to pass to aws s3 when creating/deleting/moving/copying files using aws s3
    extra_s3_args = {},
    -- EXPERIMENTAL support for performing file operations with git
    git = {
        -- Return true to automatically git add/mv/rm files
        add = function(path)
            return false
        end,
        mv = function(src_path, dest_path)
            return false
        end,
        rm = function(path)
            return false
        end,
    },
    -- Configuration for the floating window in oil.open_float
    float = {
        -- Padding around the floating window
        padding = 2,
        -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        max_width = 0,
        max_height = 0,
        border = nil,
        win_options = {
            winblend = 0,
        },
        get_win_title = nil,
        -- preview_split: Split direction: "auto", "left", "right", "above", "below".
        preview_split = "auto",
        override = function(conf)
            return conf
        end,
    },
    -- Configuration for the file preview window
    preview_win = {
        -- Whether the preview window is automatically updated when the cursor is moved
        update_on_cursor_moved = true,
        -- How to open the preview window "load"|"scratch"|"fast_scratch"
        preview_method = "fast_scratch",
        -- A function that returns true to disable preview on a file e.g. to avoid lag
        disable_preview = function(filename)
            return false
        end,
        -- Window-local options to use for preview window buffers
        win_options = {},
    },
    -- Configuration for the floating action confirmation window
    confirmation = {
        -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a single value or a list of mixed integer/float types.
        -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
        max_width = 0.9,
        -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
        min_width = { 40, 0.4 },
        -- optionally define an integer/float for the exact width of the preview window
        width = nil,
        -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_height and max_height can be a single value or a list of mixed integer/float types.
        -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
        max_height = 0.9,
        -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
        min_height = { 5, 0.1 },
        -- optionally define an integer/float for the exact height of the preview window
        height = nil,
        border = nil,
        win_options = {
            winblend = 0,
        },
    },
    -- Configuration for the floating progress window
    progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = nil,
        minimized_border = "none",
        win_options = {
            winblend = 0,
        },
    },
    -- Configuration for the floating SSH window
    ssh = {
        border = nil,
    },
    -- Configuration for the floating keymaps help window
    keymaps_help = {
        border = nil,
    },
})

map('n', 'K', function()
    if vim.bo.filetype == 'rust' then
        vim.cmd.RustLsp({ 'hover', 'actions' })
    end
end, { desc = 'Hover (RustLsp / hover.nvim)' })


require("hardtime").setup({})
require("fzf-lua").setup({})
require("dropbar").setup({
    bar = {
        -- Only show the dropbar in normal code files (hide in oil, terminal, etc.)
        enable = function(buf, win)
            return vim.fn.win_gettype(win) == ''
                and vim.bo[buf].filetype ~= 'oil'
                and vim.bo[buf].buftype == ''
        end,
    }
})

local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
    "n",
    "<leader>a",
    function()
        vim.lsp.buf.codeAction()
    end,
    { silent = true, buffer = bufnr }
)

vim.api.nvim_create_autocmd("InsertEnter", {
    once = true, -- Only execute this setup once per session
    callback = function()
        vim.pack.add({
            { src = "https://github.com/Saghen/blink.lib", },
            { src = "https://github.com/Saghen/blink.pairs", },
            { src = "https://github.com/Saghen/blink.cmp", },
            { src = "https://github.com/Saghen/blink.indent", },
            { src = "https://github.com/onsails/lspkind.nvim" },
        })
        require("blink.cmp").build():pwait()
        require('blink.pairs').build():pwait(60000)
        require('blink.pairs').setup({
            highlights = {
                groups = {
                    "BlinkPairsRed",
                    "BlinkPairsYellow",
                    "BlinkPairsBlue",
                    "BlinkPairsOrange",
                    "BlinkPairsGreen",
                    "BlinkPairsPurple",
                    "BlinkPairsCyan",
                },
            },
        })
        require("blink.cmp").setup({
            keymap = {
                preset = 'super-tab'
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono',
            },
            completion = {
                trigger = {
                    show_on_keyword = true,
                },
                keyword = { range = 'full' },
                list = { selection = { preselect = false, auto_insert = true } },
                menu = {
                    auto_show = true,
                    border = 'none',
                    draw = {
                        columns = {
                            { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" }
                        },
                        components = {
                            kind_icon = {
                                text = function(ctx)
                                    return require('lspkind').symbol_map[ctx.kind] or ''
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
            sources = {
                -- default = { 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lsp = {},
                    snippets = {},
                    path = {},
                    buffer = {
                        -- keep case of first char
                        transform_items = function(a, items)
                            local keyword = a.get_keyword()
                            local correct, case
                            if keyword:match('^%l') then
                                correct = '^%u%l+$'
                                case = string.lower
                            elseif keyword:match('^%u') then
                                correct = '^%l+$'
                                case = string.upper
                            else
                                return items
                            end
                            -- avoid duplicates from the corrections
                            local seen = {}
                            local out = {}
                            for _, item in ipairs(items) do
                                local raw = item.insertText
                                if raw:match(correct) then
                                    local text = case(raw:sub(1, 1)) .. raw:sub(2)
                                    item.insertText = text
                                    item.label = text
                                end
                                if not seen[item.insertText] then
                                    seen[item.insertText] = true
                                    table.insert(out, item)
                                end
                            end
                            return out
                        end
                    }
                }
            },
            signature = { enabled = true }
        })
        require('blink.indent').setup({
            dedent_scoped_filetypes = { include_defaults = true },
            blocked = {
                buftypes = { include_defaults = true },
                filetypes = { include_defaults = true },
            },
            mappings = {
                border = 'both',
                object_scope = 'ii',
                object_scope_with_border = 'ai',
                goto_top = '[i',
                goto_bottom = ']i',
            },
            static = {
                enabled = true,
                char = '▏',
                whitespace_char = nil, -- inherits from `vim.opt.listchars:get().space` when `nil` (see `:h listchars`)
                priority = 1,
            },
            scope = {
                enabled = true, -- highlight highest level of indentation on the current line
                char = '▎',
                priority = 1000,
                underline = {
                    enabled = true,
                },
            },
        })
    end,
})

vim.api.nvim_create_autocmd("BufRead", {
    pattern = "Cargo.toml",
    once = true,
    callback = function()
        vim.pack.add({ { src = "https://github.com/Saecki/crates.nvim" } })
        require("crates").setup()
    end,
})
-- Custom mode map to keep it down to a single letter
local mode_map = {
    ['n'] = 'N',
    ['no'] = 'N',
    ['nov'] = 'N',
    ['noV'] = 'N',
    ['no'] = 'N',
    ['i'] = 'I',
    ['ic'] = 'I',
    ['ix'] = 'I',
    ['v'] = 'V',
    ['V'] = 'V',
    [''] = 'V',
    ['c'] = 'C',
    ['cv'] = 'C',
    ['ce'] = 'C',
    ['r'] = 'R',
    ['rm'] = 'R',
    ['r?'] = 'R',
    ['s'] = 'S',
    ['S'] = 'S',
    [''] = 'S',
    ['t'] = 'T',
    ['nt'] = 'T',
}

-- require('lualine').setup {
--     options = {
--         icons_enabled = true,
--         theme = 'oxocarbon',
--         component_separators = { left = '', right = '' },
--         section_separators = { left = '', right = '' },
--         globalstatus = true,
--         disabled_filetypes = { statusline = { 'alpha', 'dashboard', 'NvimTree' } },
--     },
--     sections = {
--         lualine_a = {
--             {
--                 'mode',
--                 fmt = function()
--                     local code = vim.api.nvim_get_mode().mode
--                     return mode_map[code] or code:upper()
--                 end,
--                 color = { gui = 'bold' }
--             }
--         },
--         lualine_b = {
--             {
--                 'branch',
--                 icon = '',
--                 color = { bg = '#262626' }
--             },
--             {
--                 'diff',
--                 symbols = { added = ' ', modified = ' ', removed = ' ' },
--                 source = function()
--                     local gitsigns = vim.b.gitsigns_status_dict
--                     if gitsigns then
--                         return {
--                             added = gitsigns.added,
--                             modified = gitsigns.changed,
--                             removed = gitsigns.removed
--                         }
--                     end
--                 end,
--                 color = { bg = '#262626' }
--             }
--         },
--         lualine_c = {
--             {
--                 'filename',
--                 path = 1, -- 1 = Relative path
--                 symbols = { modified = '●', readonly = '', unnamed = '[No Name]' }
--             }
--         },
--         lualine_x = {
--             {
--                 'diagnostics',
--                 sources = { 'nvim_diagnostic' },
--                 symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌵 ' },
--                 color = { bg = '#262626' }
--             },
--             {
--                 'filetype',
--                 icon_only = true, -- Strip the text, just show the devicon
--                 color = { bg = '#262626' }
--             }
--         },
--         lualine_y = {
--             {
--                 'location',
--                 color = { bg = '#393939', fg = '#dde1e6' }
--             }
--         },
--         lualine_z = {
--             {
--                 'datetime',
--                 style = '%H:%M',
--                 icon = '',
--                 color = { bg = '#525252', fg = '#ffffff', gui = 'bold' }
--             }
--         }
--     },
--     inactive_sections = {
--         lualine_c = { 'filename' },
--         lualine_x = { 'location' }
--     }
-- }
