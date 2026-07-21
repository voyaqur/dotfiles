vim.pack.add({
    --Theme
    { src = "https://github.com/catppuccin/nvim", },
    -- Icons
    { src = "https://github.com/nvim-mini/mini.icons" },
    { src = "https://github.com/bluz71/vim-moonfly-colors", name = "moonfly" },
})
vim.cmd.colorscheme('moonfly')
