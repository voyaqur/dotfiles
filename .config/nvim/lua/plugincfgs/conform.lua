return {
    formatters_by_ft = {
        rust = { "rustfmt", fallback = "lsp" }, -- Tells conform to cleanly fallback to rust-analyzer
        c = { fallback = "lsp" }, -- Lean on clangd natively
        cpp = { fallback = "lsp" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
        lua = { "stylua", fallback = "lsp" },
    },
    format_after_save = {
        lsp_format = "fallback",
    },
    format_on_save = function()
        return {
            timeout_ms = 500,
            lsp_format = "fallback",
        }
    end,
    formatters = {
        shfmt = {
            prepend_args = { "-i", "2", "-ci", "-sr" },
        },
    },
}
