require("core.base")
require("core.opts")
require("theme")
require("core.maps")
require("treesitter")
require("core.autocmd")
require("installs")
require("debugger")
require("lang.rust")
require("lsp")

-- require("lang.haskell")
vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter" }, {
    group = nil,
    once = true,
    callback = function()
        vim.schedule(function()
            require("plugins")
            require("builtin")
        end)
    end,
})
vim.defer_fn(function()
    require("core.cmd")
end, 50)
