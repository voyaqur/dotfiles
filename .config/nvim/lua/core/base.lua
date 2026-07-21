local g = vim.g
local opt = vim.opt

-- 1. Explicitly Define Clipboard Provider BEFORE Option Initialization
-- Bypasses firejail/sandbox hangs by utilizing OSC 52 terminal pipelines
local osc52 = require("vim.ui.clipboard.osc52")
g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = osc52.copy("+"),
    ["*"] = osc52.copy("*"),
  },
  paste = {
    ["+"] = { "wl-paste", "--no-newline" },
    ["*"] = { "wl-paste", "--primary", "--no-newline" },
  },
}

-- 2. Environmental Encoding & Language Sets
vim.env.LANG = vim.fn.has("unix") == 1 and "C.UTF-8" or "en"
vim.cmd.language(vim.env.LANG)
opt.langmenu = vim.env.LANG

opt.encoding = "utf-8"
opt.fileencodings = { "ucs-bom", "utf-8", "euc-jp", "iso-2022-jp", "cp932", "sjis", "latin1" }
opt.fileformats = { "unix", "dos", "mac" }

-- 3. Kill Built-in Legacy Plugin Sourcing (Speed Optimization)
local disabled_built_ins = {
  "2html_plugin", "getscript", "getscriptPlugin", "gzip", "logiPat",
  "man", "matchit", "matchparen", "netrwFileHandlers", "netrwPlugin",
  "netrwSettings", "remote_plugins", "rplugin", "rrhelper", "shada_plugin",
  "spec", "spellfile_plugin", "tar", "tarPlugin", "tutor_mode_plugin",
  "vimball", "vimballPlugin", "zip", "zipPlugin", "black", "fzf",
  "gtags", "gtags_cscope"
}
for _, plugin in ipairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

-- Disable unneeded remote language host providers
local disabled_providers = { "node", "perl", "python3", "python", "pythonx", "ruby" }
for _, provider in ipairs(disabled_providers) do
  g["loaded_" .. provider .. "_provider"] = 0
end

-- 4. Strip Global System Paths out of your Local Runtime Isolation Line
opt.runtimepath:remove("/etc/xdg/nvim")
opt.runtimepath:remove("/etc/xdg/nvim/after")
opt.runtimepath:remove("/usr/share/vim/vimfiles")
