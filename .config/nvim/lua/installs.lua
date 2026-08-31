vim.pack.add({
    -- { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/saghen/blink.lib" },
    { src = "https://github.com/Saghen/blink.cmp" },
    { src = "https://github.com/Saghen/blink.pairs" },
    { src = "https://github.com/windwp/nvim-autopairs" }, -- Fallback for edge cases
    { src = "https://github.com/Saghen/blink.indent" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/kevinhwang91/promise-async" },
    { src = "https://github.com/kevinhwang91/nvim-ufo" },
    { src = "https://github.com/kylechui/nvim-surround" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/nvim-tree/nvim-tree.lua" },
})
require("fzf-lua").setup(require("./plugincfgs/fzf"))

-- Honorable mentions (removed):
-- { src = "https://github.com/m4xshen/hardtime.nvim" },
-- { src = "https://github.com/Bekaboo/dropbar.nvim" },
-- { src = "https://github.com/nvim-neotest/neotest" },
-- { src = "https://github.com/stevearc/overseer.nvim" },
-- { src = "https://github.com/stevearc/aerial.nvim" },
-- { src = "https://github.com/folke/todo-comments.nvim" },
-- { src = "https://github.com/RaafatTurki/hex.nvim" },
-- { src = "https://github.com/nvim-mini/mini.nvim" },
-- { src = "https://github.com/MagicDuck/grug-far.nvim" },
-- { src = 'https://github.com/FylerOrg/fyler.nvim' }
-- { src = "https://github.com/ThePrimeagen/refactoring.nvim" },
-- { src = "https://github.com/folke/trouble.nvim" },
-- { src = "https://github.com/j-hui/fidget.nvim" },
-- { src = "https://github.com/mason-org/mason.nvim" },
-- { src = "https://github.com/supermaven-inc/supermaven-nvim" },
-- { src = "https://github.com/chrisgrieser/nvim-lsp-endhints" },
-- { src = "https://github.com/giuxtaposition/blink-cmp-copilot" },
-- { src = "https://github.com/Huijiro/blink-cmp-supermaven" },
-- { src = "https://github.com/stevearc/oil.nvim" },
-- { src = "https://github.com/zbirenbaum/copilot.lua" },
-- { src = "https://github.com/jmbuhr/otter.nvim" },
--
require("nvim-tree").setup({
    hijack_netrw = true,
    disable_netrw = true,
    hijack_cursor = true,
    renderer = {
        group_empty = true,
        highlight_git = true,
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
        },
    },
    filters = {
        dotfiles = true,
        custom = { "^\\.git$" },
    },
    actions = {
        open_file = {
            quit_on_open = true, -- Keep tree open after opening a file
            resize_window = true,
            window_picker = {
                enable = true, -- Avoid opening files inside floating/special windows
            },
        },
    },
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        api.map.on_attach.default(bufnr)
        vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
    end,
    view = {
        side = "left",
        relativenumber = false,
    },
})
local set_hl = vim.api.nvim_set_hl
set_hl(0, "FzfLuaNormal", { link = "Normal" })
set_hl(0, "FzfLuaBorder", { link = "FloatBorder" })
set_hl(0, "FzfLuaPreviewNormal", { link = "Normal" })
set_hl(0, "FzfLuaPreviewBorder", { link = "FloatBorder" })
set_hl(0, "FzfLuaCursorLine", { link = "CursorLine" })
