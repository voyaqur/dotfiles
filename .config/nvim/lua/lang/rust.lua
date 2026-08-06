local map = vim.keymap.set
local rust_group = vim.api.nvim_create_augroup("LazyLoadRustTools", { clear = true })
vim.g.rustaceanvim = function()
    return {
        tools = {
            float_wins = { border = "none" }, -- rounded reads better than none for hover/actions
            hover_actions = {
                auto_focus = true,            -- jump straight into hover popup, feels more IDE-like
            },
            code_actions = {
                ui_select_fallback = true
            },
            enable_clippy = true,
            enable_nextest = true,
            reload_workspace_from_cargo_toml = true,
        },
        server = {
            cmd = { "rust-analyzer" },
            root_markers = { "Cargo.toml", "rust-project.json", "rustfmt.toml", ".git" },
            auto_attach = true,
            on_attach = function(_, bufnr)
                local opts = function(desc)
                    return { buffer = bufnr, silent = true, desc = desc }
                end
                -- Execution & Debugging
                map("n", "<leader>rr", "<cmd>RustLsp run<CR>", opts("Run Target at Cursor"))
                map("n", "<leader>rR", "<cmd>RustLsp runnables<CR>", opts("Runnables"))
                map("n", "<leader>rd", "<cmd>RustLsp debuggables<CR>", opts("Debuggables"))
                map("n", "<leader>rD", "<cmd>RustLsp debug<CR>", opts("Debug Target at Cursor"))
                map("n", "<leader>rt", "<cmd>RustLsp testables<CR>", opts("Testables"))
                map("n", "<leader>rT", "<cmd>RustLsp relatedTests<CR>", opts("Related Tests"))
                -- Code Actions & Quick Fixes
                map("n", "<leader>ra", "<cmd>RustLsp codeAction<CR>", opts("Code Action (Grouped)"))
                map("n", "<leader>re", "<cmd>RustLsp explainError<CR>", opts("Explain Error"))
                -- map("n", "<leader>rD", "<cmd>RustLsp renderDiagnostic cycle<CR>", opts("Render Diagnostic"))
                -- Code Manipulation & AST
                -- map("n", "<leader>rj", "<cmd>RustLsp joinLines<CR>", opts("Join Lines"))
                -- map("n", "<leader>rK", "<cmd>RustLsp moveItem up<CR>", opts("Move Item Up"))
                -- map("n", "<leader>rJ", "<cmd>RustLsp moveItem down<CR>", opts("Move Item Down"))
                map("n", "<leader>rp", "<cmd>RustLsp parentModule<CR>", opts("Parent Module"))
                -- map("n", "<leader>rs", "<cmd>RustLsp syntaxTree<CR>", opts("Syntax Tree"))
                -- map("n", "<leader>ru", "<cmd>RustLsp view mir<CR>", opts("View MIR"))
                -- map("n", "<leader>rU", "<cmd>RustLsp view hir<CR>", opts("View HIR"))
                -- Diagnostics & Compiler Checks
                map("n", "<leader>rx", "<cmd>RustLsp rebuildProcMacros<CR>", opts("Rebuild Proc Macros"))
                map("n", "<leader>rN", "<cmd>RustLsp relatedDiagnostics<CR>", opts("Related Diagnostics"))
                map("n", "<leader>rf", "<cmd>RustLsp flyCheck<CR>", opts("Fly Check"))
                -- Cargo & Workspace Tools
                map("n", "<leader>rc", "<cmd>RustLsp openCargo<CR>", opts("Open Cargo.toml"))
                map("n", "<leader>rw", "<cmd>RustLsp reloadWorkspace<CR>", opts("Reload Workspace"))
                -- map("n", "<leader>rg", "<cmd>RustLsp crateGraph<CR>", opts("Crate Graph"))
                -- map("n", "<leader>rW", "<cmd>RustLsp workspaceSymbol<CR>", opts("Workspace Symbols"))
                -- Documentation & Hover
                map("n", "K", "<cmd>RustLsp hover actions<CR>", opts("Hover Actions")) -- overrides default K, actions > plain hover
                map("n", "<leader>rk", "<cmd>RustLsp openDocs<CR>", opts("Open Docs.rs"))
                map("n", "<leader>rE", "<cmd>RustLsp externalDocs<CR>", opts("External Docs"))
                -- Low-Level / Compiler Inspection
                map("n", "<leader>m", "<cmd>RustLsp expandMacro<CR>", opts("Expand Macro"))
                map("n", "<leader>rS", "<cmd>RustLsp ssr<CR>", opts("Structural Search Replace"))
            end,
            -- dap = {
            -- },
            default_settings = {
                ["rust-analyzer"] = {
                    cargo = {
                        allFeatures = true,
                        autoreload = true,
                        buildScripts = { enable = true },
                        loadOutDirsFromCheck = true,
                        extraArgs = { "--target-dir", "target/rust-analyzer" },
                    },
                    workspace = {
                        symbol = {
                            search = {
                                scope = "workspace_and_dependencies",
                                kind = "all_symbols", -- includes fns/consts/etc in workspace symbol search, not just types (Ctrl+Shift+O parity)
                                limit = 128,
                            },
                        },
                    },
                    procMacro = {
                        enable = true,
                        attributes = { enable = true }, -- expand attribute proc-macros too (e.g. #[async_trait]), not just derive macros
                        -- ignored = {
                        -- 	-- ["some-crate"] = { "problematic_macro_name" }, -- silence specific macros that crash/hang expansion
                        -- },
                    },
                    checkOnSave = true,
                    check = {
                        command = "clippy",
                        extraArgs = { "--no-deps" },
                        extraEnv = { RUSTFLAGS = "-W clippy::pedantic" },
                    },
                    --
                    hover = {
                        actions = {
                            enable = true,
                            implementations = { enable = true },
                            references = { enable = true },
                            run = { enable = true },
                            debug = { enable = true },
                            gotoTypeDef = { enable = true },
                        },
                        documentation = { enable = true },
                        links = { enable = true },
                        memoryLayout = {
                            enable = true, -- shows size/align/offset in hover, e.g. hovering a struct field — genuinely RustRover/CLion-tier
                            size = "both", -- decimal + hex
                            offset = "both",
                            alignment = "both",
                            niches = true, -- shows niche optimization info (e.g. Option<&T> == size_of::<&T>())
                        },
                        show = {
                            enumVariants = 5, -- cap long enum hover listings
                            fields = 5,
                            traitAssocItems = 5,
                        },
                    },
                    interpret = { tests = true },
                    --
                    assist = {
                        emitMustUse = true,               -- adds #[must_use] when generating functions that return values
                        expressionFillDefault = "todo",   -- fills missing match arms with `todo!()` instead of `()`
                    },
                    showUnlinkedFileNotification = false, -- silences the "file not part of any crate" popup for scratch files
                    notifications = {
                        cargoTomlNotFound = true,         -- silences noise for non-cargo scratch files/subprojects
                    },
                    --
                    -- 	-- Type/trait hints even more aggressive
                    typing = {
                        autoClosingAngleBrackets = { enable = true }, -- auto-close `<>` in generics
                    },
                    cachePriming = {
                        enable = true, -- warms rust-analyzer's cache on startup so first queries aren't slow
                    },
                    lru = {
                        capacity = 512, -- bumps the query result cache; noticeably smoother on large workspaces at the cost of RAM
                    },
                    numThreads = 8,     -- tune to your core count; parallelizes indexing/checking
                    --
                    inlayHints = {
                        bindingModeHints = { enable = true },
                        chainingHints = { enable = true },
                        closingBraceHints = { enable = true, minLines = 25 },
                        closureReturnTypeHints = { enable = "always" },
                        lifetimeElisionHints = { enable = "skip_trivial" },
                        parameterHints = { enable = true },
                        typeHints = { enable = true },
                        expressionAdjustmentHints = { enable = "reborrow" }, -- shows implicit &/&mut/deref, genuinely IDE-tier
                        discriminantHints = { enable = "fieldless" },        -- shows enum discriminant values inline
                        closureCaptureHints = { enable = true },             -- shows what a closure captures and how (move/&/&mut) — big one for RustRover parity
                        closureStyle = "rust_analyzer",                      -- readable closure type hints instead of raw impl Fn(...) soup
                        implicitDrops = { enable = true },                   -- marks implicit drop points at end of scope
                        genericParameterHints = {
                            type = { enable = false },                       -- turbofish-style hints for elided generic type args; noisy, opt-in
                            lifetime = { enable = true },
                            const = { enable = true },                       -- hints for elided const generic args, usually worth it
                        },
                        maxLength = 25,                                      -- truncates very long inlay hints instead of eating half the line
                        renderColons = true,
                    },
                    diagnostics = {
                        enable = true,
                        disabled = { "unresolved-proc-macro" },
                        experimental = { enable = true }, -- turns on rust-analyzer's newer experimental diagnostics
                        styleLints = { enable = true },
                    },
                    imports = {
                        granularity = { group = "module" },
                        prefix = "self",
                    },
                    references = {
                        excludeImports = true, -- "Find references" skips the `use` statement itself, just like RustRover
                    },
                    -- runnables = {
                    -- 	extraArgs = { ""--nocapture" }, -- uncomment for test output to always show on run
                    -- },
                    lens = {
                        enabled = true,
                        implementations = { enable = true },
                        references = {
                            adt = { enable = true },
                            trait = { enable = true },
                            method = { enable = true }, -- CodeLens showing reference counts above fns/structs/traits, like RustRover's gutter icons
                        },
                        run = { enable = true },
                        debug = { enable = true },
                        location = "above_name", -- keeps lenses tight to the item name instead of floating above attributes/docs
                    },
                    files = {
                        excludeDirs = { "target", ".git" }, -- keeps file-watching off build artifacts, meaningfully faster on large workspaces
                        watcher = "client",
                    },

                    --
                    -- -- Signature help while typing function args
                    signatureInfo = {
                        detail = "full",
                        documentation = { enable = true },
                    },
                    --
                    -- -- Semantic highlighting for operators/punctuation (very RustRover-like)
                    semanticHighlighting = {
                        operator = { enable = true },
                        punctuation = { enable = true, separate = { macro = { bang = true } } },
                    },
                    --
                    rustfmt = {
                        -- extraArgs = { "+nightly" }, -- if you use nightly rustfmt features (e.g. imports_granularity in stable rustfmt.toml)
                        rangeFormatting = { enable = true }, -- lets you format-selection, not just whole-file
                    },
                    --
                    -- -- Rename via LSP applies across the whole workspace correctly
                    rename = { allowExternalItems = true },
                }
            },
        }
    }
end

vim.pack.add({
    { src = "https://github.com/mrcjkb/rustaceanvim" },
    { src = "https://github.com/cordx56/rustowl" },
    { src = "https://github.com/Saecki/crates.nvim" },
    { src = "https://github.com/nvim-neotest/neotest" },
})


local has_neotest, neotest = pcall(require, "neotest")
if has_neotest then
    neotest.setup({
        adapters = { require("rustaceanvim.neotest") },
    })
    map("n", "<leader>r1", function() neotest.run.run() end, { desc = "Run Nearest Test" })
    map("n", "<leader>r2", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Run File Tests" })
    map("n", "<leader>r3", function() neotest.output.open({ enter = true }) end, { desc = "Test Output" })
    map("n", "<leader>r4", function() neotest.summary.toggle() end, { desc = "Test Summary" })
end

vim.api.nvim_create_autocmd("BufRead", {
    group = rust_group,
    pattern = "Cargo.toml",
    callback = function(ev)
        require("crates").setup({
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
            completion = {
                cmp = { enabled = false }, -- disable if using blink.cmp, avoid double-registering a completion source
                crates = { enabled = true },
            },
        })
        local has_crates, crates = pcall(require, "crates")
        if has_crates then
            crates.show()
            local opts = { buffer = ev.buf, silent = true }
            vim.keymap.set("n", "<leader>cv", crates.show_versions_popup,
                vim.tbl_extend("force", opts, { desc = "Crate Versions" }))
            vim.keymap.set("n", "<leader>cf", crates.show_features_popup,
                vim.tbl_extend("force", opts, { desc = "Crate Features" }))
            vim.keymap.set("n", "<leader>cu", crates.update_crate,
                vim.tbl_extend("force", opts, { desc = "Update Crate" }))
            vim.keymap.set("n", "<leader>cU", crates.upgrade_crate,
                vim.tbl_extend("force", opts, { desc = "Upgrade Crate" }))
            vim.keymap.set("n", "<leader>cU", crates.upgrade_all_crates,
                vim.tbl_extend("force", opts, { desc = "Upgrade All Crates" }))
        end
    end,
})

require("rustowl").setup({
    auto_enable = false,
    auto_attach = true,
    idle_time = 2,
    highlight_style = {
        definitely_live = 'underline',
        maybe_initialized = 'undercurl',
    },
    colors = {
        -- lifetime = '#50fa7b',
        -- imm_borrow = '#8be9fd',
        -- mut_borrow = '#ff79c6',
        -- move = '#f1fa8c',
        -- call = '#ffb86c',
        outlive = '#ff5555',
    },
    client = {
        on_attach = function(_, buffer)
            vim.keymap.set('n', '<leader>ro', function()
                require('rustowl').toggle(buffer)
            end, { buffer = buffer, desc = 'Toggle RustOwl' })
        end
    },
})

local has_wk, wk = pcall(require, "which-key")
if has_wk then
    wk.add({
        { "<leader>r", group = "Rust Tools", icon = "🦀" },
        { "<leader>c", group = "Crates", icon = "📦" },
    })
end
