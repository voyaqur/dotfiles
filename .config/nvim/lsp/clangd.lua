return {
    cmd = {
        "clangd",
        "--background-index=false",      -- skip building a persistent index — irrelevant for single .cpp solves, saves startup time
        "--header-insertion=never",      -- never auto-insert #include on completion (annoying and often wrong for CP single-file setups)
        "--completion-style=detailed",
        "--function-arg-placeholders=0", -- no dummy arg placeholders cluttering completions
        "--clang-tidy=false",            -- skip tidy checks; pure CPU cost with little value mid-contest
        "--fallback-style=llvm",
        "--pch-storage=memory",          -- keep precompiled headers in RAM instead of disk — faster reparse when you edit templates/bits/stdc++.h
        "--all-scopes-completion",       -- surface symbols from all namespaces (e.g. std::) without requiring `using namespace` first
        "--limit-results=200",           -- cap completion list size so large symbol sets (bits/stdc++.h) don't lag the popup
        "--rename-file-limit=0",         -- competitive code is single-file; don't waste time scanning project-wide for renames
        "-j=4",
    },
    filetypes = { "cpp", "c" },
    root_markers = {
        ".clangd",
        "compile_commands.json",
        ".git",
    },
    init_options = {
        usePlaceholders = false,
        completeUnimported = false,
        clangdFileStatus = false,
    },
}
