vim.loader.enable()
local lsp = vim.lsp
vim.pack.add({ "https://github.com/rktjmp/lush.nvim" })
require("theme")
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚", -- nf-md-close_circle
            [vim.diagnostic.severity.WARN]  = "󰀪", -- nf-md-alert
            [vim.diagnostic.severity.HINT]  = "󰌶", -- nf-md-lightbulb
            [vim.diagnostic.severity.INFO]  = "󰋽", -- nf-md-information
        },
    },
    virtual_text = {
        severity_sort = true,
    },
    float = {
        border = "none", -- Adds sleek rounded borders to hover/error windows
    },
    underline = true,
    update_in_insert = true, -- Don't flash red text while you are mid-typing
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = nil,
    once = true,
    callback = function()
        lsp.enable({ 'lua_ls', 'clangd', 'jsonls' })
        require("config.opts")
        require("config.keymaps")
        require("builtin")
        require("debugger")
        require("plugins")
        require("config.autocmds")
    end
})
vim.g.rustaceanvim = function()
    return {
        -- Plugin configuration
        tools = {
        },
        -- LSP configuration
        server = {
            on_attach = function(client, bufnr)
                -- you can also put keymaps in here
                vim.keymap.set("n", "<leader>a", function()
                        vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
                        -- or vim.lsp.buf.codeAction() if you don't want grouping.
                    end,
                    { silent = true, buffer = bufnr }
                )
                vim.keymap.set("n", "K", function() vim.cmd.RustLsp({ 'hover', 'actions' }) end,
                    { silent = true, buffer = bufnr })
            end,
            default_settings = {
                -- rust-analyzer language server configuration
                ['rust-analyzer'] = {
                    filetypes = { "rust" },
                    cmd = { "rust-analyzer" },
                    root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },
                    settings = {
                        ["rust-analyzer"] = {
                            inlayHints = {
                                bindingModeHints = { enable = true },
                                chainingHints = { enable = true },
                                closingBraceHints = { enable = true, minLines = 25 },
                                parameterHints = { enable = true },
                                typeHints = { enable = true },
                            },
                            workspace = {
                                symbol = {
                                    search = { scope = "workspace_and_dependencies" } -- Better workspace-wide search
                                }
                            },
                            diagnostics = {
                                enable = true,
                                disabled = { "unresolved-proc-macro" }, -- Prevents annoying macro false-positives
                            },
                            imports = {
                                granularity = {
                                    group = "module",
                                },
                                prefix = "self",
                            },
                            cargo = {
                                buildScripts = {
                                    enable = true,
                                },
                            },
                            procMacro = {
                                enable = true
                            },
                            checkOnSave = false,
                        },
                    },
                },
            },
        },
        -- DAP configuration
        dap = {

        },
    }
end
