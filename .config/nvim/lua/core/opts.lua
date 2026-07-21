local g = vim.g
local opt = vim.opt

require("vim._core.ui2").enable({})
-- 1. Global Variables & Leaders
g.mapleader = " "
g.maplocalleader = "\\"
g.have_nerd_font = true
g.editorconfig_enable = true
g.vimsyn_embed = "l"

-- Terminal color pass-through configuration
g.colorterm = os.getenv("COLORTERM")

-- Make sure the explicit global viminfofile exists for Shada state tracking
g.viminfofile = g.viminfofile or (vim.fn.stdpath("state") .. "/shada/main.shada")
vim.fn.mkdir(vim.fn.fnamemodify(vim.fn.expand(g.viminfofile), ":h"), "p")
-- 2. Performance, Paths & Disk State Caching
opt.updatetime = 2000
opt.timeout = true
opt.timeoutlen = 500
opt.ttimeoutlen = 10
opt.history = 10000
opt.synmaxcol = 200 -- Prioritized 200 over 240 based on your latest config

vim.defer_fn(function()
	vim.cmd.syntax("enable")
end, 50)

-- ShaDa (Shared Data) configuration
opt.shada = "'50,<1000,s100,\"1000,!"
opt.shadafile = vim.fn.stdpath("state") .. "/shada/main.shada"

-- Persistent Undo State
opt.undofile = true
opt.undodir = vim.fn.stdpath("state") .. "/undo/"
vim.fn.mkdir(opt.undodir:get()[1], "p")

-- Backup Engine Setup
opt.backup = true
opt.backupdir = vim.fn.stdpath("state") .. "/backup/"
vim.fn.mkdir(opt.backupdir:get()[1], "p")
opt.backupskip = ""
opt.writebackup = false

-- Swap Engine Safeties
opt.swapfile = false
opt.directory = vim.fn.stdpath("state") .. "/swap/"
vim.fn.mkdir(opt.directory:get()[1], "p")
opt.updatecount = 100

-- External System Behaviors
opt.autoread = true
opt.modeline = false

-- 3. UI, Window Layouts & Aesthetics
opt.confirm = true
opt.showmode = false
opt.ruler = false
opt.showtabline = 2
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.pumblend = 0
opt.pumheight = 10
opt.winminwidth = 5
opt.laststatus = 3 -- High-performance global single statusline rule
opt.display = "lastline"
opt.shortmess = "aItToOF"

-- Title Bar Customization
opt.title = true
opt.titlestring = "nvim:%t"

-- Mouse & Audio Notifications
opt.mouse = ""
opt.mousescroll = "ver:0,hor:0"
opt.errorbells = false
opt.visualbell = false

-- Bracket & Parentheses Matching
opt.showmatch = true
opt.matchtime = 1

-- Cursor Mechanics & Highlight Layouts
opt.guicursor = "n-v-c-sm:block-Cursor/lCursor-blinkon0,i-ci-ve:ver25-Cursor/lCursor,r-cr-o:hor20-Cursor/lCursor"
opt.cursorline = true -- Switched off based on your latest layout preferences
-- opt.cursorlineopt = "number"

-- Split Window Mechanics
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "cursor"
opt.equalalways = false

-- Clean Custom UI Borders & Character Masks
opt.list = true
opt.listchars = {
	tab = "» ",
	space = "·"
}
opt.fillchars = {
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

-- Native Advanced Dynamic Status Column Setup
opt.statuscolumn = "%=%{&nu ? v:relnum && mode() != 'i' ? v:relnum : v:lnum : ''} %s%C"

-- Navigation & Scrolling Fields
opt.smoothscroll = true
opt.scrolloff = 5 -- Prioritized 5 over 10 based on latest paste
opt.sidescrolloff = 5

-- =============================================================================
-- 4. Text Display, Indents & Line Rules
-- =============================================================================
opt.number = true
opt.relativenumber = true
opt.wrap = true -- Flipped to true to prioritize your newest wrapping preference
opt.linebreak = true
opt.breakindent = true
opt.virtualedit = "block"
opt.showcmd = true
opt.cmdheight = 0

-- Tab Expansion Rules
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 4
opt.expandtab = false
opt.shiftround = true

-- Folding System Rules
opt.foldmethod = "manual" -- Prioritized manual over indent based on newest paste
opt.foldlevel = 1
opt.foldlevelstart = 99
vim.w.foldcolumn = "0:" -- Scoped locally to window definitions

-- Inter-line joins and editing options
opt.backspace = { "indent", "eol", "start" }
opt.formatoptions:append("m")
opt.fixendofline = false

-- =============================================================================
-- 5. Search, Complete & Context Menus
-- =============================================================================
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.wrapscan = true
opt.inccommand = "split"

-- Native Word Completion Modifiers
opt.complete:append("k")
opt.completeopt = { "menuone", "noselect", "noinsert" }

-- Popup Menu Configuration Blocks
opt.wildmenu = true
opt.wildmode = { "longest", "list", "full" }
opt.wildoptions:append("pum")
opt.wildignore:append({
	"*/.git/*",
	"*/node_modules/*",
	"*/build/*",
	"*/target/*",
	"*.o",
	"*.obj",
	"*.exe",
	"*.so",
	"*.dll",
	"*.pyc",
})

if vim.fn.has("clipboard") == 1 then
	opt.clipboard = { "unnamedplus", "unnamed" }
end

-- Tag Path Extractions
opt.tags:remove({ "./tags", "./tags;" })
opt.tags:prepend("./tags")

-- Session management tracking points
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "globals" }
opt.switchbuf = { "useopen", "uselast" }

-- Spell Engine Settings
opt.spelllang = { "en", "cjk" }
vim.opt_local.spelloptions:append("noplainbuffer")

-- Modern Side-by-Side Diff Generation Tables
opt.diffopt = { "vertical", "internal", "algorithm:patience", "iwhite", "indent-heuristic" }

-- Number Formats
opt.nrformats:append("unsigned")

-- Global Diagnostic Architecture Config
vim.diagnostic.config({
	virtual_text = { source = true },
	float = { source = true },
})

