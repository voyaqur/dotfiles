-- keep
vim.pack.add({
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    -- maybe one day i'll revisit this one
    -- { src = 'https://github.com/voyaqur/theric.nvim' },
    { src = "https://github.com/craftzdog/solarized-osaka.nvim" },
})

require("solarized-osaka").setup({
    transparent = false,
    terminal_colors = true,
    styles = {
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
    },
    hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard StatusLine and LuaLine.
    dim_inactive = true, -- dims inactive windows
    lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
})

vim.cmd("colorscheme solarized-osaka")
