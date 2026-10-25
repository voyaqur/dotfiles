return {
    cmd = { "tinymist" },
    filetypes = { "typst" },
    settings = {
        -- PDF Export Settings
        exportPdf = "onSave", -- "never" | "onSave" | "onType"
        outputPath = "$dir/$name", -- Saves output next to the source file (e.g., build/ or $root/target/$dir/$name)

        -- Formatter Configuration
        formatterMode = "typstyle", -- "typstyle" | "typstfmt" | "disable"
        formatterPrintWidth = 120, -- Preferred line width
        formatterProseWrap = "sentence", -- "none" | "fill" | "sentence" (great for clean git diffs)

        -- Code Completion & Postfix Rules
        completion = {
            postfix = true, -- Allows `[A].box` -> `box[A]`
            symbol = "stepless", -- "step" | "stepless" (stepless symbol completion like `$ar$` -> `$arrow.r$`)
        },

        -- Font & System Integration
        systemFonts = true, -- Set to false if you want strict reproducible builds using explicit fontPaths
        fontPaths = {}, -- Extra directories containing custom `.ttf`/`.otf` fonts

        -- Feature Toggles
        semanticTokens = "enable", -- Enables LSP-based syntax highlighting
        syntaxOnly = "auto",
    },
}
