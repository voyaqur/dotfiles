-- keep
vim.pack.add({
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
    -- maybe one day i'll revisit this one
    -- { src = 'https://github.com/voyaqur/theric.nvim' },
    { src = 'https://github.com/craftzdog/solarized-osaka.nvim' },

})

require("solarized-osaka").setup {
    transparent = true,
    terminal_colors = true,
    styles = {
        comments = { italic = false },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark"
    },
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard StatusLine and LuaLine.
    dim_inactive = true,              -- dims inactive windows
    lualine_bold = true,              -- When `true`, section headers in the lualine theme will be bold
}
vim.cmd("colorscheme solarized-osaka")
