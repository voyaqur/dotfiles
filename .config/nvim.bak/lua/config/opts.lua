local g = vim.g
local opt = vim.opt

--G
opt.cmdheight = 0
g.mapleader = " "
g.maplocalleader = "//"
g.have_nerd_font = true
--O
opt.background = "dark"

--Options
opt.completeopt = "menu,menuone,noselect,popup,nearest"
-- folding
opt.foldlevel = 99
opt.foldmethod = "indent"
opt.foldtext = ""

--smart things
opt.ignorecase = true
opt.smartcase = true
opt.smartindent = true
opt.hlsearch = false
opt.mouse = "a"
opt.inccommand = "split"

opt.autowrite = true
--line &indenting
opt.number = true
opt.relativenumber = true
opt.shiftround = true
opt.breakindent = true
opt.cursorline = true
opt.confirm = true
opt.clipboard = "unnamedplus"
opt.linebreak = true
opt.termguicolors = true
opt.wrap = false

--Scrolling
opt.smoothscroll = true
opt.scrolloff = 10
opt.sidescrolloff = 8
opt.signcolumn = "yes"

--undoing
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200

--Layouts
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"

opt.spelllang = { "en" }

opt.virtualedit = "block"
opt.tabstop = 4
opt.softtabstop = 4
opt.showmode = false
opt.ruler = false

opt.shiftwidth = 4
opt.expandtab = true

--Popup
opt.pumblend = 10
opt.pumheight = 10

opt.wildmode = "longest:full,full"
opt.wildoptions = "pum"
opt.winminwidth = 5
opt.cmdheight = 0
opt.showtabline = 2 -- Always show the tabline

opt.winborder = "single"

-- local org = vim.lsp.util.open_floating_preview
--
-- ---@diagnostic disable-next-line: duplicate-set-field
-- vim.lsp.util.open_floating_preview = function(contents, syntax, opts)
--     opts = opts or {}
--     opts.max_height = 40
--     opts.max_width = 40
--     return org(contents,syntax,opts)
-- end
-- opt.completeopt:append("popup")
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit",
}

for _, plugin in ipairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end
