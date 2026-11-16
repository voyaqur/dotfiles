return {
    cmd = { "tinymist" },
    filetypes = { "typst" },
    settings = {
        -- PDF Export Settings
        exportPdf = "onType", -- "never" | "onSave" | "onType"
        outputPath = "$dir/$name", -- Saves output next to the source file (e.g., build/ or $root/target/$dir/$name)

        -- Formatter Configuration
        formatterMode = "typstyle", -- "typstyle" | "typstfmt" | "disable"
        formatterPrintWidth = 120, -- Preferred line width
        formatterProseWrap = "sentence", -- "none" | "fill" | "sentence" (great for clean git diffs)

        completion = {
            postfix = true, -- Allows `[A].box` -> `box[A]`
            symbol = "stepless", -- "step" | "stepless" (stepless symbol completion like `$ar$` -> `$arrow.r$`)
        },

        systemFonts = true,
        fontPaths = {}, -- Extra directories containing custom `.ttf`/`.otf` fonts

        semanticTokens = "enable", -- Enables LSP-based syntax highlighting
        syntaxOnly = "auto",
    },
}
