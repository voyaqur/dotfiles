-- ~/.config/nvim/lsp/jsonls.lua
return {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    init_options = {
        provideFormatter = true,
    },
    capabilities = (function()
        local caps = vim.lsp.protocol.make_client_capabilities()
        caps.textDocument.completion.completionItem.snippetSupport = true
        return caps
    end)(),
    settings = {
        json = {
            validate = { enable = true },
        },
    },
}
