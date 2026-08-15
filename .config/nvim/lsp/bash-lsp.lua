return {
    filetypes = { "sh", "bash", "inc", "command" },
    cmd = { "bash-language-server", "start" },
    root_markers = { ".git", ".shellcheckrc", ".shfmt" },
    settings = {
        bashIde = {
            -- Workspace indexing controls
            globPattern = "*@(.sh|.inc|.bash|.command)",

            -- Background file scanning behavior
            includeAllWorkspaceSymbols = true,

            -- Integrated ShellCheck linter tuning
            shellcheckArguments = "--shell=bash --enable=all --external-sources",
            shellcheckPath = "shellcheck",

            -- Integrated shfmt formatter tuning
            shfmt = {
                path = "shfmt",
                ignoreEditorconfig = false,
                -- Arguments passed to shfmt:
                -- -i 2 (indent 2 spaces), -ci (switch case indent), -sr (space after redirect)
                spaceRedirects = true,
                caseIndent = true,
            },

            -- Environment & Execution overrides
            bashPath = "bash",

            -- Explanations on hover / completion details
            explanationHandlerEndpoint = "https://explainshell.com/explain",

            -- Log verbosity for troubleshooting LSP connections
            logLevel = "info",
        },
    },
}
